class SiteTopNavigationController < ApplicationController

  include SportsHelper

  def coefficients
    #@title = I18n.t(:top_menu_coefficients)
    @news_blocks = NewsBlock.all(:limit => 5)
    @counter = NewsBlock.all.count
 	  @sports = Sport.all
    #@bet_types = BetType.all
   # @bookmakers = Bookmaker.all
    respond_to do |format|
      format.html {
        @top_event = League.first.events.first
      }
      format.js {
        @league = League.find_by_id( params[:sport_id].gsub("league_", "").to_i )
        @bookmakers = @league.events
      }
    end
  end

  def bookmakers
    #@title = I18n.t(:top_menu_bookmakers)
    @sports = Sport.all
  end

  def statistics
    #@title = I18n.t(:top_menu_statistics)
    @sports = Sport.all
  end

  def tools
   # @title = I18n.t(:top_menu_ools)
    @sports = Sport.all
  end

end

