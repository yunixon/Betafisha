ENV["RAILS_ENV"] ||= "development"
BOOKMAKER = "Gamebookers"
AVAILABLE_BETTYPES = ["Outright", "Versus (with Draw)", "To Win the Match"]
SPORTS = ['basketball', 'football', 'ice_hockey', 'tennis']

require File.dirname(__FILE__) + "/../config/application"
require 'open-uri'

Rails.application.require_environment!


_bookmaker = Bookmaker.find_or_create_by_name BOOKMAKER

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
          if AVAILABLE_BETTYPES.include?(bettype['name'])
            Common.create(:table_name => 'bet_type', :element_name => bettype['name'])
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
