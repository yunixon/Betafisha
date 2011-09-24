class SiteTopNavigationController < ApplicationController

  include SportsHelper

  def coefficients
    #@title = I18n.t(:top_menu_coefficients)
    @news_blocks = NewsBlock.all(:limit => 5)
    @counter = NewsBlock.all.count
 	  @sports = Sport.all
    @coupon = Coupon.new
    respond_to do |format|
      format.html {
        @top_event = League.first.events.first
        @bookmakers = @top_event.bets.find( :all,
									  :select     => "bookmaker_id, COUNT(bookmaker_id) AS duplicate_count",
									  :conditions => "bookmaker_id IS NOT NULL",
									  :group      => "bookmaker_id HAVING duplicate_count >= 1")
      }
      format.js {
        ActiveRecord::Base.logger.info "!!!!!!!!!!!!!!!!!!!!!!" + params.inspect
        if params['type'] == 'add_to_coupon'
          current_user.coupons.find_or_create_by_league_id params[:sport_id].gsub("league_", "").to_i
        elsif params['type'] == 'remove_to_coupon'
          coupon = Coupon.find_by_league_id params[:sport_id].gsub("league_", "").to_i
          coupon.destroy
        end

        @has_ligue = current_user.coupons.find_by_league_id params[:sport_id].gsub("league_", "").to_i
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

