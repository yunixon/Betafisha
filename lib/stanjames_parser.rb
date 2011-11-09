class StanjamesParser
  BOOKMAKER = "StanJames"
  URL = 'http://xml.stanjames.com/'
  SPORTS = {
    :ice_hockey => ['icehockey', 'icehockey-germany', 'icehockey-russia' ],
    :basketball => ['basketball-russia', 'basketball-spain', 'basketball-germany', 
                    'basketball-france', 'basketball-italy', 'basketball-greece', 
                    'basketball-turkey', 'basketball-us'
                   ],
    :tennis => ['tennis-ladies', 
                'tennis-matches', 
                'tennis-mens', 
                'tennis-outrights'
                ],
    :football => ['football-ukraine', 'football-portugal', 'football-paraguay', 
                  'football-argentina', 'football-austria', 'football-belgium', 
                  'football-brazil', 'football-conference', 'football-denmark', 
                  'football-euro-champions-league','football-finland', 'football-france', 
                  'football-germany', 'football-holland', 'football-hungary', 
                  'football-italy', 'football-major-league-soccer', 'football-mexico', 
                  'football-poland', 'football-portugal', 'football-premiership', 
                  'football-russia', 'football-south-america', 'football-worldcup', 
                  'football-spain', 'football-sweden', 'football-switzerland', 
                  'football-turkey'
                 ]
    }

  def self.parse!
    _bookmaker = Bookmaker.find_or_create_by_name BOOKMAKER
    _bookmaker.touch

    SPORTS.each do |pair|
      pair.last.each do |url|
        ActiveRecord::Base.logger.info URL + url + '.XML'
        doc = Nokogiri::HTML(open(URL + url + '.XML'))
        doc.xpath('//event').each do |event|
          _sport_name = calculate_name(StanJame, event['sporttype'], 'sport')
          _sport = Sport.find_or_create_by_name _sport_name
          check_previous_names(event['sporttype'], _sport_name, Sport, :sport_id, _sport.id, [:leagues])
          _sport.touch

          _country_name = ''
          _country = nil
          Common.countries.each do |c|
            if event['sport'].include?(c.element_name)
              _country_name = calculate_name(StanJame, c.element_name, 'country')
              _country = Country.find_or_create_by_name _country_name
              check_previous_names(c.element_name, _country_name, Country, :country_id, _country.id, [:leagues])
              _country.touch
            end
          end

          unless _country_name.present?
            event.children.each do |bettype|
              _country_name = calculate_name(StanJame, 'World', 'country')
              _country = Country.find_or_create_by_name _country_name
              _country.touch
            end
          end

          _league_name = calculate_name(StanJame,
                                          [_sport.name,
                                            _country.name,
                                            event['sport']
                                          ].join(' | '),
                                          'league',
                                          true,
                                          [_sport.name, _country.name, event['sport']]
                                        )
          _league = League.find_or_create_by_name _league_name
          _league.sport_id = set_attribute_unless_given(_league, :sport_id, _sport.id)
          _league.country_id = set_attribute_unless_given(_league, :country_id, _country.id)
          _league.save
          check_previous_names([_sport.name, _country.name, event['sport']].join(' | '),
                                _league_name,
                                League,
                                :league_id,
                                _league.id,
                                [:events, :coupons])
          _league.touch

          _event_name = calculate_name(StanJame, event['name'], 'event')
          _event = Event.find_or_create_by_name _event_name
          _event.league_id = set_attribute_unless_given(_event, :league_id, _league.id)
          _event.save
          check_previous_names(event['name'], _event_name, Event, :event_id, _event.id, [:participants, :bets])
          _event.touch

          if event['name'].scan(' v ').present?
            event.children.each do |bettype|
              _bet_type_name = calculate_name(StanJame, bettype['name'], 'bet_type', false)
              if _bet_type_name.present?
                _bet_type = BetType.find_or_create_by_name _bet_type_name
                _bet_type.touch

                bettype.children.each do |bet|
                  _participant_name      = calculate_name(StanJame, bet['name'], 'participant')
                  _participant           = Participant.find_or_create_by_name _participant_name
                  _participant.event_id  = set_attribute_unless_given(_participant, :event_id, _event.id)
                  _participant.save
                  _participant.touch

                  _bet                   = Bet.create
                  _bet.participant_id    = set_attribute_unless_given(_bet, :participant_id, _participant.id)
                  _bet.bet_type_id       = set_attribute_unless_given(_bet, :bet_type_id, _bet_type.id)
                  _bet.event_id          = set_attribute_unless_given(_bet, :event_id, _event.id)
                  _bet.bookmaker_id      = set_attribute_unless_given(_bet, :bookmaker_id, _bookmaker.id)
                  _bet.odd               = set_attribute_unless_given(_bet, :odd, bet['pricedecimal'])
                  _bet.name              = set_attribute_unless_given(_bet, :name, _participant_name)
                  _bet.save
                  _bet.touch

                end
              end
            end
          else
            event.children.each do |bettype|
              _bet_type_name = calculate_name(StanJame, bettype['name'], 'bet_type', false)
              if _bet_type_name.present?
                _bet_type = BetType.find_or_create_by_name _bet_type_name
                _bet_type.touch

                bettype.children.each do |bet|
                  _participant_name     = calculate_name(StanJame, bet['name'], 'participant')
                  _participant          = Participant.find_or_create_by_name _participant_name
                  _participant.event_id = set_attribute_unless_given(_participant, :event_id, _event.id)
                  _participant.save
                  _participant.touch

                  _bet                = Bet.create
                  _bet.participant_id = set_attribute_unless_given(_bet, :participant_id, _participant.id)
                  _bet.bet_type_id    = set_attribute_unless_given(_bet, :bet_type_id, _bet_type.id)
                  _bet.event_id       = set_attribute_unless_given(_bet, :event_id, _event.id)
                  _bet.bookmaker_id   = set_attribute_unless_given(_bet, :bookmaker_id, _bookmaker.id)
                  _bet.odd            = set_attribute_unless_given(_bet, :odd, bet['pricedecimal'])
                  _bet.name           = set_attribute_unless_given(_bet, :name, bet['name'])
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

