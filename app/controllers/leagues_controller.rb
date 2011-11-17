class LeaguesController < ApplicationController
  
  before_filter :authenticate, :only => [:edit, :update, :destroy]
  before_filter :admin_user, :only => [:edit, :update, :destroy]

  include CalculatingName

  def index
    @leagues = League.all
  end

  def new
    @leagues = League.all
  end

  def create
    @sports = Sport.all
    @success = false
    
    country = Country.find(params[:league][:country_id])
    sport = Sport.find(params[:league][:sport_id])

    league_name_full = [ sport.name, country.name, params[:league][:name] ].join(' | ') unless params[:league][:name] == ""
 
    @league = League.find_or_create_by_name league_name_full
    @league.title = params[:league][:name]
    @league.sport_id = set_attribute_unless_given(@league, :sport_id, sport.id)
    @league.country_id = set_attribute_unless_given(@league, :country_id, country.id)
       
    respond_to do |format|
      format.html { redirect_to leagues_manager_path}
      format.js {
        if @league.save
          calculate_common_name(league_name_full, 'league') unless league_name_full.nil?
          @success = true
        else
          @success = false
        end
      }
    end
  end

  def show
    @sports = Sport.all
    @coupon = Coupon.new
    @league = League.find(params[:id])
    if signed_in?
      @has_ligue = current_user.coupons.find_by_league_id params[:id]
    end
  end

  def edit
    @league = League.find(params[:id])

  end

  def update
   #!!!!!!!!!!!!!!!!!
    @league = League.find(params[:id])
    @league.update_attributes(params[:league])
    
    respond_to do |format|
      format.html
      format.js { @sports = Sport.all }
    end
  end

  def destroy

    league = League.find(params[:id])
    common_value = Common.find_by_element_name league.name

    @sport_id = league.sport.id
    @country_id = league.country.id

    league.destroy
    common_value.destroy unless common_value.nil?

    respond_to do |format|
      format.js { @sports = Sport.all }
    end
  end

  def leaguetocoupon
    if signed_in?
      respond_to do |format|
        format.js {
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

end

