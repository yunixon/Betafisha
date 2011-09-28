ENV["RAILS_ENV"] ||= "development"
BOOKMAKER = "Gamebookers"
SPORTS = ['basketball', 'football', 'ice_hockey', 'tennis']

COMMON_BETTYPES = ['Outright', '1x2', '1or2']
GAMEBOOKERS = ['Outright', 'Versus (with Draw)', ['To Win the Match', 'Versus', 'Draw No Bet']]
BETREDKINGS = ['Winner', 'Home Draw Away', 'Home Away With Impossible Draw']
NORDICBET = ['Result Winner', 'Result (OutcomeSet has 3 children nodes)', 'Result (OutcomeSet has 2 children nodes)']
STANJAMES = [["NBA Outright", "Eastern Conference", "Western Conference",
              "Tournament Outright Prices", "Outright Prices", "Australian Open 2012",
              "Wimbledon 2012", "French Open 2012", "Australian Open 2012",
              "Davis Cup Outright 2011", "Men's Wimbledon 2012", "US Open 2012"],
              'Match Betting',
              ["Draw No Bet", "Match Winner", "Match Prices"]]


require File.dirname(__FILE__) + "/../config/application"
require 'open-uri'

Rails.application.require_environment!


_bookmaker = Bookmaker.find_or_create_by_name BOOKMAKER

#Separately finding all betypes for each bookmaker
COMMON_BETTYPES.each_with_index do |c,i|
  common = Common.create(:element_name => c, :table_name => 'bet_type')
  GAMEBOOKERS[i].each do |g|
    Gamebooker.create(:element_name => g, :table_name => 'bet_type', :common_id => common.id)
  end
  BETREDKINGS[i].each do |b|
    Betredking.create(:element_name => b, :table_name => 'bet_type', :common_id => common.id)
  end
  NORDICBET[i].each do |n|
    Nordicbet.create(:element_name => n, :table_name => 'bet_type', :common_id => common.id)
  end
  STANJAMES[i].each do |s|
    StanJame.create(:element_name => s, :table_name => 'bet_type', :common_id => common.id)
  end
end

#main commonize calculation by gamebooker logic
SPORTS.each do |style|
  doc = Nokogiri::HTML(open("http://xml.gamebookers.com/sports/#{style}.xml_attr.xml"))
  doc.xpath('//sport').each do |sport|
    Common.create(:table_name => 'sport', :element_name => sport['name'])
    sport.children.each do |group|
      _country_name = group['name'].include?('~') ? 'World' : group['name'].split(' - ').first
      _league_name = group['name'].include?('~') ? group['name'].gsub('~','') : group['name'].split(' - ').last
      Common.create(:table_name => 'country', :element_name => _country_name)
      Common.create(:table_name => 'league', :element_name => _league_name)
      group.children.each do |event|
        Common.create(:table_name => 'event', :element_name => event['name'])
        event.children.each do |bettype|
          if GAMEBOOKERS.flatten.include?(bettype['name'])
            bettype.children.each do |bet|
              _team_name = bet['outcome_name'] == 'X' ? 'Draw' : bet['outcome_name']
              Common.create(:table_name => 'participant', :element_name => _team_name)
            end
          end
        end
      end
    end
  end
end
