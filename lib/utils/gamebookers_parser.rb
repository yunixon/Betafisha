class GamebookersParser

  require 'rubygems'
  require "net/http"
  require 'rexml/document'
  require 'nokogiri'
  require 'open-uri'
  require 'savon'

  def self.parse

    settings = YAML.load_file("#{ Rails.root.join('config','bookmakers') }/gamebookers.yml")

    #if settings == nil
      # ...
    #end

    settings["odds_by_sport"].each do |url|

      BetafishaLogger.print_log( url )

      document = Nokogiri::XML( open( url ) )
      events = document.search( "//event" )

      events.each do |event|

        current_sport_id = event.search( ".//sportID" ).text.to_i
        current_sport_name = event.search( ".//sportname" ).text

        current_ligue_id = event.search(".//leagueID").text.to_i
        current_ligue_name = event.search(".//league").text

        current_team1_id = event.search(".//team1ID").text.to_i
        current_team1_name = event.search(".//team1").text

        current_team2_id = event.search(".//team2ID").text.to_i
        current_team2_name = event.search(".//team2").text



        betafisha_sport = Sport.find( :first, :conditions => { :name => current_sport_name } )

        if betafisha_sport != nil

          gamebookers_sport =  GameBookersOdd.find( :first, :conditions => { :gamebookers_id => current_sport_id } )

          if gamebookers_sport == nil
            GameBookersOdd.create!( :betafisha_id => betafisha_sport.id,
                                    :gamebookers_id =>  current_sport_id,
                                    :name => current_sport_name,
                                    :table_name => 'sports' )
          end  # if

          gamebookers_ligue =  GameBookersOdd.find( :first, :conditions => { :gamebookers_id => current_ligue_id } )


          if gamebookers_ligue == nil
            GameBookersOdd.create!( :gamebookers_id =>  current_ligue_id,
                                    :name => current_ligue_name,
                                    :table_name => 'ligues' )
          end  # if

          gamebookers_team1 =  GameBookersOdd.find( :first, :conditions => { :gamebookers_id => current_team1_id } )

          if gamebookers_team1 == nil
            GameBookersOdd.create!( :gamebookers_id => current_team1_id,
                                    :name => current_team1_name,
                                    :table_name => 'teams' )

          end # if

          gamebookers_team2 =  GameBookersOdd.find( :first, :conditions => { :gamebookers_id => current_team2_id } )

          if gamebookers_team2 == nil
            GameBookersOdd.create!( :gamebookers_id => current_team2_id,
                                    :name => current_team2_name,
                                    :table_name => 'teams' )

          end # if


        end # if

      end # do
    end # do

  end

end