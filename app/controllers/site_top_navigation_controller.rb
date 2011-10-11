class SiteTopNavigationController < ApplicationController

  include SportsHelper

  def coefficients

 	  @sports = Sport.all
    @bet_type_filter = params[:filter_type] ||= "allin-filter"

   ActiveRecord::Base.logger.info @bet_type_filter.split("-")[0]

    respond_to do |format|
      format.html {
        @top_event = League.limit(5).first(:order => "rand()").events.first

        if !@top_event.nil? and !@top_event.bets.nil?
          @bookmakers = @top_event.bets.find( :all,
									    :select     => "bookmaker_id, COUNT(bookmaker_id) AS duplicate_count",
									    :conditions => "bookmaker_id IS NOT NULL",
									    :group      => "bookmaker_id HAVING duplicate_count >= 1")
		    end
      }
      format.js {
        @bet_type_filter = @bet_type_filter.split("-")[0]
        @league = League.find_by_id( params[:sport_id].gsub("league_", "").to_i )
        @bookmakers = @league.events
      }
    end
  end

  def bookmakers
    @sports = Sport.all
  end

  def statistics
    @sports = Sport.all
  end

  def tools
    @sports = Sport.all
  end

end

