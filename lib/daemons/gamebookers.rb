begin
#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "development"

require File.dirname(__FILE__) + "/../../config/application"

require 'rubygems'
require "net/http"
require 'rexml/document'
require 'nokogiri'
require 'open-uri'
require 'savon' 

Rails.application.require_environment!

$running = true
Signal.trap("TERM") do 
  $running = false
end

#BookmakerCoefficients.destroy_all
 ActiveRecord::Base.logger.auto_flushing = true
 ActiveRecord::Base.logger.info "$$$ GameBookers log: Update started at #{ Time.now } \n"
  
while $running do

  uri = 'http://xml.gamebookers.com/activeodds.xml'
  document = Nokogiri::XML ( open( uri ) ) 
 
  events = document.search("//event")
  
  ActiveRecord::Base.logger.auto_flushing = true
  ActiveRecord::Base.logger.info "$$$ GameBookers log: Update started at #{ Time.now } \n"
  ActiveRecord::Base.logger.info "$$$ RSS updated at #{ document.search("//last_modified").text } \n" 
  
  events.each do |event| 

   team2 = ""
   odd2 = ""

    if event.search(".//team2") 
       team2 = event.search(".//team2").text 
    else
       team2 = ""
    end

    if event.search(".//odd2") 
      odd2 = event.search(".//odd2").text 
    else
      odd2 = event.search(".//odd3").text
    end
                            
    GameBookersOdd.create!(         :bookmaker_id => "gamebookers", 
                                    :sport_id => event.search(".//sportname").text,
                                    :ligue_id => event.search(".//league").text, 
                                    :team_one_id => event.search(".//team1").text, 
                                    :team_two_id => team2,
                                    :sportsmen_id => "", 
                                    :bet_type_id => event.search(".//type").text, 
                                    :team_one_coef => event.search(".//odd1").text, 
                                    :team_two_coef => odd2, 
                                    :sportsmen_coef => "" 
                                  )    
  end

  sleep 20
  
end 




end
