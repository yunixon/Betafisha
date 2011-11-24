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
    _participants_hash = {}
    bets_array = []

    COMMON_SPORTS.each do |style|
      doc = Nokogiri::HTML(open("http://aws2.betredkings.com/feed/#{style}.xml"))

      doc.xpath('//sport').each do |sport|
        _sport_name = calculate_name(Betredking, sport['name'], 'sport')
        _sport = Sport.find_or_create_by_name _sport_name
        check_previous_names(sport['name'], _sport_name, Sport, :sport_id, _sport.id, [:leagues])
        _sport.touch

        sport.children.each do |country|
          _country_name = calculate_name(Betredking, country['name'], 'country')
          _country = Country.find_or_create_by_name _country_name
          check_previous_names(country['name'], _country_name, Country, :country_id, _country.id, [:leagues])
          _country.touch

          country.children.each do |tournament|
            _tournament_name = tournament['name']
            _league_name = calculate_name(Betredking,
                                          [_sport.name,
                                            _country.name,
                                            _tournament_name
                                          ].join(' | '),
                                          'league',
                                          true,
                                          [_sport.name, _country.name, _tournament_name]
                                          )

            _league = League.find_or_create_by_name _league_name
            _league.sport_id = set_attribute_unless_given(_league, :sport_id, _sport.id)
            _league.country_id = set_attribute_unless_given(_league, :country_id, _country.id)
            _league.save
            check_previous_names([_sport.name, _country.name, _tournament_name].join(' | '),
                                  _league_name,
                                  League,
                                  :league_id,
                                  _league.id,
                                  [:events, :coupons])
            _league.touch

            _participants_hash.clear
            tournament.children.each do |match|
              _participants_array.clear
              if match.name == 'match'
                _match_name = ''
                _match_name << match.children.children[0]['name'] << ' - ' << match.children.children[1]['name']
                _event_name = calculate_name(Betredking, _match_name, 'event')
                _event = Event.find_or_create_by_name _event_name
                _event.league_id = set_attribute_unless_given(_event, :league_id, _league.id)
                _event.save
                check_previous_names(_match_name, _event_name, Event, :event_id, _event.id, [:participants, :bets])
                _event.touch

                match.children.each do |element|
                  case element.name
                  when 'participants' then
                    element.children.each do |participant|
                      _participants_array << participant
                      _team_name = calculate_name(Betredking, participant['name'], 'participant')
                      _team = Participant.find_or_create_by_name _team_name
                      _team.event_id = set_attribute_unless_given(_team, :event_id, _event.id)
                      _team.save
                      _team.touch
                    end
                  when 'matchodds' then
                    element.children.each do |type|
                      _type_name = calculate_name(Betredking, type['type'], 'bet_type', false)
                      if _type_name.present?
                        if (_type_name == '1x2' or _type_name == '1or2') && !type['scope'].downcase.include?('full time')
                        else
                          _type = BetType.find_or_create_by_name _type_name

                          bets_array.clear
                          type.children.each_with_index do |odd, i|
                            _bet = Bet.new :priority => 1
                            position = 0
                            case odd['outcome']
                            when '1' then
                              _bet_name = _participants_array[0]['name']
                              position = 0
                            when '2' then
                              _bet_name = _participants_array[1]['name']
                              position = 2
                            when 'X' then
                              _bet_name = 'Draw'
                              position = 1
                            end

                            _bet.name = _bet_name
                            _bet.bet_type_id = set_attribute_unless_given(_bet, :bet_type_id, _type.id)
                            _bet.event_id = set_attribute_unless_given(_bet, :event_id, _event.id)
                            _bet.bookmaker_id = set_attribute_unless_given(_bet, :bookmaker_id, _bookmaker.id)
                            _bet.odd = set_attribute_unless_given(_bet, :odd, odd.text)
                            bets_array[position] = _bet
                          end
                          bets_array.each do |b|
                            b.save if b.present?
                            b.touch if b.present?
                          end

                        end
                      end
                    end
                  end
                end
              else
              #      
                _event_name = calculate_name(Betredking, _league_name, 'event')
                _event = Event.find_or_create_by_name _event_name
                _event.league_id = set_attribute_unless_given(_event, :league_id, _league.id)
                _event.save
                check_previous_names(_league_name, _event_name, Event, :event_id, _event.id, [:participants, :bets])
                _event.touch

                case match.name
                when 'participants' then
                  match.children.each do |participant|
                    _participants_hash[participant['id']] = participant['name']
                    _team_name = calculate_name(Betredking, participant['name'], 'participant')
                    _team = Participant.find_or_create_by_name _team_name
                    _team.event_id = set_attribute_unless_given(_team, :event_id, _event.id)
                    _team.save
                    _team.touch
                  end
                when 'tournamentodds' then
                  match.children.each do |type|
                    _type_name = calculate_name(Betredking, type['type'], 'bet_type', false)
                    if _type_name.present?
                      _type = BetType.find_or_create_by_name _type_name
                      type.children.each_with_index do |odd, i|
                        _bet = Bet.new :priority => 1
                        _bet.name = set_attribute_unless_given(_bet, :name, _participants_hash[odd['participantid']])
                        _bet.bet_type_id = set_attribute_unless_given(_bet, :bet_type_id, _type.id)
                        _bet.event_id = set_attribute_unless_given(_bet, :event_id, _event.id)
                        _bet.bookmaker_id = set_attribute_unless_given(_bet, :bookmaker_id, _bookmaker.id)
                        _bet.odd = set_attribute_unless_given(_bet, :odd, odd.text)
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

