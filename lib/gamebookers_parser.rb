class GamebookersParser

  BOOKMAKER = "Gamebookers"
  SPORTS = ['american_football', 'athletics', 'aussie_rules', 'badminton', 'bandy',
    'baseball', 'basketball', 'beach_volleyball', 'bowls', 'boxing__and__mma', 'chess',
    'cricket', 'cycling', 'darts', 'financials', 'floorball', 'football', 'gaelic_sports',
    'golf', 'handball', 'horse_racing', 'ice_hockey', 'lacrosse', 'lotteries', 'motor_sports',
    'poker', 'politics', 'rugby', 'snooker__and__pool', 'specials', 'squash', 'summer_olympics',
    'swimming', 'table_tennis', 'tennis', 'trotting', 'virtual_dog_racing', 'virtual_football',
    'virtual_horse_racing', 'virtual_motor_racing', 'virtual_speedway', 'volleyball', 'waterpolo',
    'winter_olympics', 'winter_sports', '~junior_european_championship_(ladies)~']
  COMMON_SPORTS = ['basketball', 'football', 'ice_hockey', 'tennis']

  def self.parse!
    _bookmaker = Bookmaker.find_or_create_by_name BOOKMAKER
    _bookmaker.touch
    bets_hash = {}

    COMMON_SPORTS.each do |style|
      doc = Nokogiri::HTML(open("http://xml.gamebookers.com/sports/#{style}.xml_attr.xml"))
      doc.xpath('//sport').each do |sport|
        _sport_name = calculate_name(Gamebooker, sport['name'], 'sport')
        _sport = Sport.find_or_create_by_name _sport_name
        _sport.touch

        sport.children.each do |group|
          _country_name = group['name'].include?('~') ? 'World' : group['name'].split(' - ').first
          _common_country_name = calculate_name(Gamebooker, _country_name, 'country')
          _country = Country.find_or_create_by_name _common_country_name
          _country.touch

          _league_name = group['name'].include?('~') ? group['name'].gsub('~','') : group['name'].split(' - ').last
          _league_name = group['name'] if group['name'].split(' - ').last == 'Championship'
          _common_league_name = calculate_name(Gamebooker, _league_name, 'league')
          _league = League.find_or_create_by_name _common_league_name
          _league.sport_id = _sport.id
          _league.country_id = _country.id
          _league.save
          _league.touch

          group.children.each do |event|
            _event_name = calculate_name(Gamebooker, event['name'].gsub(' [Draw No Bet]', ''), 'event')
            _event = Event.find_or_create_by_name _event_name
            _event.league_id = _league.id
            _event.save
            _event.touch
            event.children.each do |bettype|
              _bet_type_name = calculate_name(Gamebooker, bettype['name'], 'bet_type', false)
              if _bet_type_name.present?
                _bet_type = BetType.find_or_create_by_name _bet_type_name
                _bet_type.touch

                bets_hash.clear
                bettype.children.each do |bet|
                  _team = Participant.new
                  _team_name = calculate_name(Gamebooker, (bet['outcome_name'] == 'X' ? 'Draw' : bet['outcome_name']), 'participant')
                  _team.name = _team_name
                  _team.event_id = _event.id
                  _team.save
                  _team.touch

                  _bet = Bet.new :priority => 1
                  _bet.event_id = _event.id
                  _bet.participant_id = _team.id
                  _bet.bet_type_id = _bet_type.id
                  _bet.bookmaker_id = _bookmaker.id
                  _bet.name = bet['outcome_name'] == 'X' ? 'Draw' : bet['outcome_name']
                  _bet.odd = bet['odd']
                  bets_hash[bet['outcome_name']] = _bet
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

