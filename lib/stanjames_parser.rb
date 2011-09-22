class StanjamesParser
  BOOKMAKER = "StanJames"
  URL = 'http://xml.stanjames.com/'
  SPORTS = {
    :ice_hockey => ['icehockey'],
    :basketball => ['basketball-college', 'Basketball-conextra', 'basketball-euroleague', 'basketball-italy',
      'basketball-international', 'basketball-us', 'basketball', 'Basketballbysport'],
    :tennis => ['tennis-ladies', 'tennis-matches', 'tennis-mens', 'tennis-outrights'],
    :football => ['football-antepost', 'football-antepost2', 'football-argentina', 'football-austria',
      'football-austria2', 'football-belgium', 'football-brazil', 'football-coca-cola1', 'football-coca-cola2',
      'football-conference', 'football-czech-div1', 'football-denmark', 'football-euro-champions-league',
      'Football-Euro-Club-Competions-Markets', 'Football-Euro-Leagues-Markets', 'football-finland',
      'Football-EuroLeagues-Cups-Markets', 'football-france', 'football-germany', 'football-germany4',
      'football-holland', 'football-hungary', 'football-international2', 'football-italy', 'football-major-league-soccer',
      'FootBall-Match-Prices', 'football-mexico', 'Football-NonEuro-Leagues-Markets', 'Football-NonUk-Markets',
      'football-poland', 'football-portugal', 'football-premiership', 'football-romania-liga1', 'football-russia',
      'football-scottish-non-prem', 'football-scottish-prem', 'football-south-america',
      'football-spain', 'football-spanishcups', 'football-sweden', 'football-sweden2', 'football-switzerland', 'football-thechampionship',
      'football-turkey', 'football-uk-cups', 'football-unibond-league', 'football-worldcup', 'FootballUkpromotions' ]
    }

  def self.parse!
    _bookmaker = Bookmaker.find_or_create_by_name BOOKMAKER
    _bookmaker.touch

    SPORTS.each do |pair|
      pair.last.each do |url|
        doc = Nokogiri::HTML(open(URL + url + '.XML'))
        doc.xpath('//event').each do |event|
          _sport_name = calculate_name(StanJame, event['sporttype'], 'sport')
          _sport = Sport.find_or_create_by_name _sport_name
          _sport.touch

          _country_name = ''
          _country = nil
          Common.countries.each do |c|
            if event['sport'].include?(c.element_name)
              _country_name = calculate_name(StanJame, c.element_name, 'country')
              _country = Country.find_or_create_by_name _country_name
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

          _league_name = calculate_name(StanJame, event['sport'], 'league')
          _league = League.find_or_create_by_name _league_name
          _league.sport_id = _sport.id
          _league.country_id = _country.id
          _league.save
          _league.touch

          _event_name = calculate_name(StanJame, event['name'], 'event')
          _event = Event.find_or_create_by_name _event_name
          _event.league_id = _league.id
          _event.save
          _event.touch

          if event['name'].scan(' v ').present?
            event['name'].split(' v ').each do |participant|
              _participant_name = calculate_name(StanJame, participant, 'participant')
              _participant = Participant.find_or_create_by_name _participant_name
              _participant.event_id = _event.id
              _participant.save
              _participant.touch

              event.children.each do |bettype|
                _bet_type_name = calculate_name(StanJame, bettype['name'], 'bet_type')
                _bet_type = BetType.find_or_create_by_name _bet_type_name
                _bet_type.touch

                bettype.children.each do |bet|
                  _bet = Bet.create :name => bettype['name']
                  _bet.odd = bet['pricedecimal'].to_i
                  _bet.event_id = _event.id
                  _bet.participant_id = _participant.id
                  _bet.bet_type_id = _bet_type.id
                  _bet.bookmaker_id = _bookmaker.id
                  _bet.save
                  _bet.touch
                end
              end
            end
          else
            event.children.each do |bettype|
              _bet_type_name = calculate_name(StanJame, bettype['name'], 'bet_type')
              _bet_type = BetType.find_or_create_by_name _bet_type_name
              _bet_type.touch

              bettype.children.each do |bet|
                _participant_name = calculate_name(StanJame, bet['name'], 'participant')
                _participant = Participant.find_or_create_by_name _participant_name
                _participant.event_id = _event.id
                _participant.save
                _participant.touch
                
                _bet = Bet.create :name => bettype['name']
                _bet.odd = bet['pricedecimal'].to_i
                _bet.event_id = _event.id
                _bet.participant_id = _participant.id
                _bet.bet_type_id = _bet_type.id
                _bet.bookmaker_id = _bookmaker.id
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
