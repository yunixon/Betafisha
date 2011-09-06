class AdminController < ApplicationController

  before_filter :authenticate
  before_filter :admin_user
  
  uses_tiny_mce
  
  layout 'admin'
  
  include AdminHelper
  
  def index 
  end
  
  def add_bookmaker_relation
  
  	redirect_to admin_bookmakers_manager_path, :notice => 'Test.'
  end
 
  def bookmakers_manager
	if signed_in? && current_user.admin?
		@gamebookers = Gamebooker.where(:table_name => 'sport')
		@bookmakers = Bookmaker.all

	  	respond_to do |format|
        	format.html {
        		@selected_bookmaker = 'Gamebookers'
        	 	@values = Gamebooker.where(:table_name => 'sport')   	 	
        	 }
        	format.js {
        	 	@selected_bookmaker = params[:bookmaker_name]
        	 	@selected_table = params[:table_name]	
        	 	@values =  get_bookmaker_values @selected_bookmaker, @selected_table
        	 	@gamebookers = Gamebooker.where(:table_name => @selected_table)
        	}   	
      	end
	end
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
      @sports = Sport.all
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
