class AdminController < ApplicationController

  before_filter :authenticate
  before_filter :admin_user
  uses_tiny_mce
  layout 'admin'
  
  def index 
  end
  
  def users_manager
    if signed_in? && current_user.admin?
      @users = User.all
      @users = User.order(:name).page params[:page]
    end
  end

  def leagues_manager
    if signed_in? && current_user.admin?
      @league = League.new
      respond_to do |format|
        format.html
        format.js
      end
    end
  end
  
  def pages_manager
    if signed_in? && current_user.admin?
      @page = Page.new
      @pages = Page.all
      @pages = Page.order(:name).page params[:page]
      #respond_to do |format|
      #  format.html
      #  format.js
      #end
    end
  end
  
  def news_manager
  
  end
  
  # creation and edition
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
   
  def league_new
    if signed_in? && current_user.admin?
      @league = League.new
      respond_to do |format|
        format.html
        format.js
      end
    end
   end 
 
   def league_edit
    if signed_in? && current_user.admin?
      @league = League.find(params[:id])
      respond_to do |format|
        format.html
        format.js
      end
    end
   end 
  

end
