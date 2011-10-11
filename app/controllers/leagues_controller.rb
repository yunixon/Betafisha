class LeaguesController < ApplicationController

  before_filter :admin_user, :only => [:edit, :update, :destroy]

  def index
    @leagues = League.all
  end

  def new
    @leagues = League.all
  end

  def create
    @league = League.create!(params[:league])
      @success = false
      respond_to do |format|
        format.html
        format.js {
          if @league.save
            @success = true
            @sports = Sport.all
          else
            @success = false
            @sports = Sport.all
          end
        }
      end
  end

  def show
    @sports = Sport.all
    @coupon = Coupon.new
    @league = League.find(params[:id])
    @has_ligue = current_user.coupons.find_by_league_id params[:id]
  end

  def edit
    @league = League.find(params[:id])

  end

  def update
    @league = League.find(params[:id])
    @league.update_attributes(params[:league])

    respond_to do |format|
      format.html
      format.js { @sports = Sport.all }
    end
  end

  def destroy
    league = League.find(params[:id])

    @sport_id = league.sport.id
    @country_id = league.country.id

    league.destroy
    respond_to do |format|
      format.js { @sports = Sport.all }
    end
  end

  def leaguetocoupon
    respond_to do |format|
      format.js{
        @league = League.find(params[:sport_id].gsub("league_", "").to_i)
        if params['type'] == 'add_to_coupon'
         current_user.coupons.find_or_create_by_league_id params[:sport_id].gsub("league_", "").to_i
        elsif params['type'] == 'remove_from_coupon'
         coupon = Coupon.find_by_league_id params[:sport_id].gsub("league_", "").to_i
         coupon.destroy
        end
        @has_ligue = current_user.coupons.find_by_league_id params[:sport_id].gsub("league_", "").to_i
      }
    end
   end

end

