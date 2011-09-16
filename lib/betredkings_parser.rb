class BetredkingsParser

  BOOKMAKER = "Betredkings"

  SPORTS = ["AFL", "Baseball", "Cycling", "Fighting", "Football", "GaelicFootball", "Handball", "Hurling",
    "MotorRacing", "RugbyUnion", "Tennis", "Am.Football", "Basketball", "Darts", "Floorball",
    "Futsal", "Golf", "HorseRacing", "IceHockey", "RugbyLeague", "Snooker", "Volleyball"]
  COMMON_SPORTS = ['Basketball', 'Football', 'IceHockey', 'Tennis']

  def self.parse!
    _bookmaker = Bookmaker.find_or_create_by_name BOOKMAKER

    COMMON_SPORTS.each do |style|
      doc = Nokogiri::HTML(open("http://aws2.betredkings.com/feed/#{style}.xml"))

      doc.xpath('//sport').each do |sport|
        _sport_name = calculate_name(Betredking, sport['name'], 'sport')
        _sport = Sport.find_or_create_by_name _sport_name

        sport.children.each do |country|
          _country_name = calculate_name(Betredking, country['name'], 'country')
          _country = Country.find_or_create_by_name _country_name

          country.children.each do |tournament|
            _league_name = calculate_name(Betredking, tournament['name'], 'league')
            _league = League.find_or_create_by_name _league_name
            _league.sport_id = _sport.id
            _league.country_id = _country.id
            _league.save
            tournament.children.each do |match|
              if match.name == 'match'
                _match_name = ''
                _match_name << match.children.children[0]['name'] << ' - ' << match.children.children[1]['name']
                _event_name = calculate_name(Betredking, _match_name, 'event')
                _event = Event.find_or_create_by_name _event_name
                _event.league_id = _league.id
                _event.save
                match.children.each do |element|
                  case element.name
                  when 'participants' then
                    element.children.each do |participant|
                      _team_name = calculate_name(Betredking, participant['name'], 'participant')
                      _team = Participant.new(:name => _team_name, :priority => 1)
                      _team.event_id = _event.id
                      _team.save
                    end
                  when 'matchodds' then
                    element.children.each do |type|
                      _type_name = calculate_name(Betredking, type['type'], 'bet_type')
                      _type = BetType.find_or_create_by_name _type_name
                      type.children.each do |odd|
                        _bet = Bet.new :priority => 1
                        _bet.name = type['scope']
                        _bet.bet_type_id = _type.id
                        _bet.event_id = _event.id
                        _bet.bookmaker_id = _bookmaker.id
                        _bet.odd = odd.text
                        _bet.save
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

