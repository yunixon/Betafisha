class NordicbetsParser

  BOOKMAKER = "Nordicbets"
  SPORTS = ['basketball', 'football', 'tennis', 'ice_hockey']

  def self.parse!
    @_bookmaker = Bookmaker.find_or_create_by_name BOOKMAKER
    @_bookmaker.touch

    SPORTS.each do |style|
      doc = Nokogiri::HTML(open("http://xml.nordicbet.com/#{style}.xml"))
      doc.xpath('//game').each do |game|
        game.children.each do |element|

          case element.name
          when 'sport' then
            _sport_name = calculate_name(Nordicbet, element.text, 'sport')
            @_sport = Sport.find_or_create_by_name _sport_name
            check_previous_names(element.text, _sport_name, Sport, :sport_id, @_sport.id, [:leagues])
            @_sport.touch
          when 'region' then
            _country_name = calculate_name(Nordicbet, element.text, 'country')
            @_country = Country.find_or_create_by_name _country_name
            check_previous_names(element.text, _country_name, Country, :country_id, @_country.id, [:leagues])
            @_country.touch
          when 'season' then
            _league_name = calculate_name(Nordicbet,
                                            [@_sport.name,
                                              @_country.name,
                                              element.text
                                            ].join(' | '),
                                            'league',
                                            true,
                                            [@_sport.name, @_country.name, element.text]
                                          )
            @_league = League.find_or_create_by_name _league_name
            @_league.sport_id = set_attribute_unless_given(@_league, :sport_id, @_sport.id)
            @_league.country_id = set_attribute_unless_given(@_league, :country_id, @_country.id)
            @_league.save
            check_previous_names([@_sport.name, @_country.name, element.text].join(' | '),
                                  _league_name,
                                  League,
                                  :league_id,
                                  @_league.id,
                                  [:events, :coupons])
            @_league.touch
          when 'breadcrumbs' then
            _event_name = calculate_name(Nordicbet, element.text, 'event')
            @_event = Event.find_or_create_by_name _event_name
            @_event.league_id = set_attribute_unless_given(@_event, :league_id, @_league.id)
            @_event.save
            check_previous_names(element.text, _event_name, Event, :event_id, @_event.id, [:participants, :bets])
            @_event.touch
          when 'participant' then
            _participant_name = calculate_name(Nordicbet, element.text, 'participant')
            @_participant = Participant.find_or_create_by_name _participant_name
            @_participant.event_id = set_attribute_unless_given(@_participant, :event_id, @_event.id)
            @_participant.save
            @_participant.touch
          when 'outcomeset' then

            if element['type'] == 'Result'
              count_of_outcomes = 0
              element.children.each do |outcome|
                count_of_outcomes += 1 if outcome.name == 'outcome'
              end
              _bettype_name = calculate_name(Nordicbet, count_of_outcomes == 2 ? 'Result' : 'Result with draw', 'bet_type', false)
            else

              _bettype_name = calculate_name(Nordicbet, element['type'], 'bet_type', false)
            end
            if _bettype_name.present?
              @_bettype = BetType.find_or_create_by_name _bettype_name
              @_bettype.touch

              element.children.each do |outcome|
                @_bet_odd = outcome['odds']
                outcome.children.each do |bet|
                  if bet.name == 'participant'
                    _bet                   = Bet.new
                    _bet.participant_id    = set_attribute_unless_given(_bet, :participant_id, @_participant.id)
                    _bet.bet_type_id       = set_attribute_unless_given(_bet, :bet_type_id, @_bettype.id)
                    _bet.event_id          = set_attribute_unless_given(_bet, :event_id, @_event.id)
                    _bet.bookmaker_id      = set_attribute_unless_given(_bet, :bookmaker_id, @_bookmaker.id)
                    _bet.odd               = set_attribute_unless_given(_bet, :odd, @_bet_odd)
                    _bet.name              = set_attribute_unless_given(_bet, :name, bet.text)
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
