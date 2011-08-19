class AdminController < ApplicationController

  before_filter :authenticate
  before_filter :admin_user

  layout 'admin'

  def users_manager
    if signed_in? && current_user.admin?
      @sports = Sport.all
      @users = User.all
      @users = User.order(:name).page params[:page]
    end
  end

  def sports_manager
    if signed_in? && current_user.admin?
      @sports = Sport.all
      @ligue = Ligue.new
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def sport_new
    if signed_in? && current_user.admin?
      @sport = Sport.new
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def sport_edit
    if signed_in? && current_user.admin?
      @sport = Sport.find(params[:id])
      respond_to do |format|
        format.html
        format.js
      end
    end
  end
 
  def country_new
    if signed_in? && current_user.admin?
      @country = Country.new
      respond_to do |format|
        format.html
        format.js
      end
    end
   end 
 
   def country_edit
    if signed_in? && current_user.admin?
      @country = Country.find(params[:id])
      respond_to do |format|
        format.html
        format.js
      end
    end
   end 
   
  def ligue_new
    if signed_in? && current_user.admin?
      @ligue = Ligue.new
      respond_to do |format|
        format.html
        format.js
      end
    end
   end 
 
   def ligue_edit
    if signed_in? && current_user.admin?
      @ligue = Ligue.find(params[:id])
      respond_to do |format|
        format.html
        format.js
      end
    end
   end 
  

end
