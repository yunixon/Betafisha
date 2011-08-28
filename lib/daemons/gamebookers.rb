begin
#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "development"
BOOKMAKER = "Gamebookers"
AVAILABLE_BETTYPES = ["Outright", "Versus (with Draw)", "To Win the Match"]
SPORTS = ['american_football', 'athletics', 'aussie_rules', 'badminton', 'bandy',
  'baseball', 'basketball', 'beach_volleyball', 'bowls', 'boxing__and__mma', 'chess',
  'cricket', 'cycling', 'darts', 'financials', 'floorball', 'football', 'gaelic_sports',
  'golf', 'handball', 'horse_racing', 'ice_hockey', 'lacrosse', 'lotteries', 'motor_sports',
  'poker', 'politics', 'rugby', 'snooker__and__pool', 'specials', 'squash', 'summer_olympics',
  'swimming', 'table_tennis', 'tennis', 'trotting', 'virtual_dog_racing', 'virtual_football',
  'virtual_horse_racing', 'virtual_motor_racing', 'virtual_speedway', 'volleyball', 'waterpolo',
  'winter_olympics', 'winter_sports', '~junior_european_championship_(ladies)~']

require File.dirname(__FILE__) + "/../../config/application"
require 'open-uri'

Rails.application.require_environment!

$running = true
Signal.trap("TERM") do 
  $running = false
end

_bookmaker = Bookmaker.find_or_create_by_name BOOKMAKER

while $running do
  SPORTS.each do |style|
    doc = Nokogiri::HTML(open("http://xml.gamebookers.com/sports/#{style}.xml_attr.xml"))
    doc.xpath('//sport').each do |sport|
      _sport = Sport.find_or_create_by_name sport['name']
      sport.children.each do |group|
        _country_name = group['name'][0] != '~' ? group['name'].split(' - ').first : 'World'
        _league_name = group['name'][0] != '~' ? group['name'].split(' - ').last : group['name'].gsub('~','')
        _country = Country.find_or_create_by_name _country_name
        _league = Ligue.new :name => _league_name, :priority => 1
        _league.sport_id = _sport.id
        _league.country_id = _country.id
        _league.save
        group.children.each do |event|
          _event = Event.create :name => event['name'], :ligue_id => _league.id, :priority => 1
          event.children.each do |bettype|
            if AVAILABLE_BETTYPES.include?(bettype['name'])
              _bet_type = BetType.create :name => bettype['name'], :priority => 1
              bettype.children.each do |bet|
                _team = Team.new
                _team.name = bet['outcome_name'] == 'X' ? 'Draw' : bet['outcome_name']
                _team.event_id = _event.id
                _team.save
                _bet = Bet.new :priority => 1
                _bet.event_id = _event.id
                _bet.team_id = _team.id
                _bet.bet_type_id = _bet_type.id
                _bet.bookmaker_id = _bookmaker.id
                _bet.name = bet['outcome_name'] == 'X' ? 'Draw' : bet['outcome_name']
                _bet.odd = bet['odd']
                _bet.save
              end
            end
          end
        end
      end
    end
  end

  sleep 86400
end 

end
