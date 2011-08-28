begin
#!/usr/bin/env ruby

ENV["RAILS_ENV"] ||= "development"
BOOKMAKER = "Betredkings"

#spors of that bookmaker. Can be added more
SPORTS = ["AFL", "Baseball", "Cycling", "Fighting", "Football", "GaelicFootball", "Handball", "Hurling",
  "MotorRacing", "RugbyUnion", "Tennis", "Am.Football", "Basketball", "Darts", "Floorball",
  "Futsal", "Golf", "HorseRacing", "IceHockey", "RugbyLeague", "Snooker", "Volleyball"]

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
    doc = Nokogiri::HTML(open("http://aws2.betredkings.com/feed/#{style}.xml"))

    doc.xpath('//sport').each do |sport|
      _sport = Sport.find_or_create_by_name sport['name']
      sport.children.each do |country|
        _country = Country.find_or_create_by_name country['name']
        country.children.each do |tournament|
          _ligue = Ligue.create :name => tournament['name'], :priority => 1,
            :sport_id => _sport.id, :country_id => _country.id
          tournament.children.each do |match|
            if match.name == 'match'
              _match_name = ''
              _match_name << match.children.children[0]['name'] << ' - ' << match.children.children[1]['name']
              _event = Event.new :name => _match_name, :priority => 1
              _event.ligue_id = _ligue.id
              _event.save
              match.children.each do |element|
                case element.name
                  when 'participants' then
                    element.children.each do |participant|
                      _team = Team.new(:name => participant['name'], :priority => 1)
                      _team.event_id = _event.id
                      _team.save
                    end
                  when 'matchodds' then
                    element.children.each do |type|
                      _type = BetType.create :name => type['type'], :priority => 1
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

  #One time per day
  sleep 86400
end

end


