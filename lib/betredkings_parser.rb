class BetredkingsParser

  BOOKMAKER = "Betredkings"

  SPORTS = ["AFL", "Baseball", "Cycling", "Fighting", "Football", "GaelicFootball", "Handball", "Hurling",
    "MotorRacing", "RugbyUnion", "Tennis", "Am.Football", "Basketball", "Darts", "Floorball",
    "Futsal", "Golf", "HorseRacing", "IceHockey", "RugbyLeague", "Snooker", "Volleyball"]
  COMMON_SPORTS = ['Basketball', 'Football', 'IceHockey', 'Tennis']

  def self.parse!
    _bookmaker = Bookmaker.find_or_create_by_name BOOKMAKER
    _bookmaker.touch
    _participants_array = []
    
    COMMON_SPORTS.each do |style|
      doc = Nokogiri::HTML(open("http://aws2.betredkings.com/feed/#{style}.xml"))

      doc.xpath('//sport').each do |sport|
        _sport_name = calculate_name(Betredking, sport['name'], 'sport')
        _sport = Sport.find_or_create_by_name _sport_name
        _sport.touch

        sport.children.each do |country|
          _country_name = calculate_name(Betredking, country['name'], 'country')
          _country = Country.find_or_create_by_name _country_name
          _country.touch

          country.children.each do |tournament|
            _league_name = calculate_name(Betredking, tournament['name'], 'league')
            _league = League.find_or_create_by_name _league_name
            _league.sport_id = _sport.id
            _league.country_id = _country.id
            _league.save
            _league.touch

            tournament.children.each do |match|
              _participants_array.clear
              if match.name == 'match'
                _match_name = ''
                _match_name << match.children.children[0]['name'] << ' - ' << match.children.children[1]['name']
                _event_name = calculate_name(Betredking, _match_name, 'event')
                _event = Event.find_or_create_by_name _event_name
                _event.league_id = _league.id
                _event.save
                _event.touch

                match.children.each do |element|
                  case element.name
                  when 'participants' then
                    element.children.each do |participant|
                      _participants_array << participant
                      _team_name = calculate_name(Betredking, participant['name'], 'participant')
                      _team = Participant.new(:name => _team_name, :priority => 1)
                      _team.event_id = _event.id
                      _team.save
                      _team.touch
                    end
                  when 'matchodds' then
                    element.children.each do |type|
                      _type_name = calculate_name(Betredking, type['type'], 'bet_type', false)
                      if _type_name.present?
                        _type = BetType.find_or_create_by_name _type_name
                        type.children.each_with_index do |odd, i|
                          _bet = Bet.new :priority => 1
                          _bet.name = case odd['outcome']
                                      when '1' then 
                                        _participants_array[0]['name']
                                      when '2' then
                                        _participants_array[1]['name']
                                      when 'X' then
                                        'Draw'
                                      end
                          _bet.bet_type_id = _type.id
                          _bet.event_id = _event.id
                          _bet.bookmaker_id = _bookmaker.id
                          _bet.odd = odd.text
                          _bet.save
                          _bet.touch
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

