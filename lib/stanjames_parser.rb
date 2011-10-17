class StanjamesParser
  BOOKMAKER = "StanJames"
  URL = 'http://xml.stanjames.com/'
  SPORTS = {
    :ice_hockey => ['icehockey'],
    :basketball => ['basketball-college', 'basketball-euroleague', 'basketball-italy',
      'basketball-international', 'basketball-us', 'basketball'],
    :tennis => ['tennis-ladies', 'tennis-matches', 'tennis-mens', 'tennis-outrights'],
    :football => ['football-argentina', 'football-austria',
      'football-austria2', 'football-belgium', 'football-brazil',
      'football-conference', 'football-czech-div1', 'football-denmark', 'football-euro-champions-league',
       'football-finland', 'football-france', 'football-germany',
      'football-holland', 'football-hungary', 'football-international2', 'football-italy', 'football-major-league-soccer',
       'football-mexico',
      'football-poland', 'football-portugal', 'football-premiership', 'football-romania-liga1', 'football-russia',
      'football-scottish-non-prem', 'football-scottish-prem', 'football-south-america',
      'football-spain', 'football-spanishcups', 'football-sweden', 'football-sweden2', 'football-switzerland', 'football-thechampionship',
      'football-turkey','football-worldcup' ]
    }

  def self.parse!
    _bookmaker = Bookmaker.find_or_create_by_name BOOKMAKER
    _bookmaker.touch
    bets_hash = {}

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
            event.children.each do |bettype|
              _bet_type_name = calculate_name(StanJame, bettype['name'], 'bet_type', false)
              if _bet_type_name.present?
                _bet_type = BetType.find_or_create_by_name _bet_type_name
                _bet_type.touch

                bets_hash.clear
                bettype.children.each do |bet|
                  _participant_name = calculate_name(StanJame, bet['name'], 'participant')
                  _participant = Participant.find_or_create_by_name _participant_name
                  _participant.event_id = _event.id
                  _participant.save
                  _participant.touch

                  _bet = Bet.create :name => _participant_name
                  _bet.odd = bet['pricedecimal']
                  _bet.event_id = _event.id
                  _bet.participant_id = _participant.id
                  _bet.bet_type_id = _bet_type.id
                  _bet.bookmaker_id = _bookmaker.id
                  bets_hash[bet['name']] = _bet
                end
              end
            end
          else
            event.children.each do |bettype|
              _bet_type_name = calculate_name(StanJame, bettype['name'], 'bet_type', false)
              if _bet_type_name.present?
                _bet_type = BetType.find_or_create_by_name _bet_type_name
                _bet_type.touch

                bets_hash.clear
                bettype.children.each do |bet|
                  _participant_name     = calculate_name(StanJame, bet['name'], 'participant')
                  _participant          = Participant.find_or_create_by_name _participant_name
                  _participant.event_id = _event.id
                  _participant.save
                  _participant.touch

                  _bet                  = Bet.create :name => bet['name']
                  _bet.odd              = bet['pricedecimal']
                  _bet.event_id         = _event.id
                  _bet.participant_id   = _participant.id
                  _bet.bet_type_id      = _bet_type.id
                  _bet.bookmaker_id     = _bookmaker.id
                  bets_hash[bet['name']] = _bet
                end  
                bets_hash.sort.each do |b|
                  b.last.save
                  b.last.touch
                end

              end
            end
          end
        end
      end
    end
  end
end

