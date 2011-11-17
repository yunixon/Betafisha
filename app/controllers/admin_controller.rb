class AdminController < ApplicationController

  before_filter :authenticate
  before_filter :admin_user

  uses_tiny_mce

  layout 'admin'

  include AdminHelper

  def add_bookmaker_relation
    @params = params[:admin]
    @bookmakers = Bookmaker.all
    respond_to do |format|
      format.js {
        @element = bookmaker_element_by_id(@params[:bookmaker_name], @params[:bookmaker_element_id])
        if !@element.nil?
          #ActiveRecord::Base.logger.info @element.element_name
            @element.update_attributes( :common_id => @params[:element_id] )
            @element.save :validate => false
          # check_previous_names(_league_name, _event_name, Event, :event_id, _event.id, [:participants, :bets])
        end
        @elements =  bookmaker_elements_by_common_id(@params[:bookmaker_name], @params[:element_id])
        @common_values = bookmaker_values_with_parents Common.where(:table_name => @params[:table_name]), @params[:table_name]
        @values = bookmaker_values_with_parents((bookmaker_values @params[:bookmaker_name], @params[:table_name]), @params[:table_name])
      }
    end
  end

  def delete_bookmaker_relation
    @params = params
    @bookmakers = Bookmaker.all
    respond_to do |format|
    format.js {
     @element = bookmaker_element_by_id(@params[:bookmaker_name], @params[:bookmaker_element_id])
     if !@element.nil?
        @element.update_attributes(:common_id => nil)
        @element.save :validate => false
     end
      @elements =  bookmaker_elements_by_common_id(@params[:bookmaker_name], @params[:element_id])
      #  ActiveRecord::Base.logger.info @elements.inspect + @params[:element_id]
      @common_values = bookmaker_values_with_parents Common.where(:table_name => @params[:table_name]), @params[:table_name]
      @values = bookmaker_values_with_parents((bookmaker_values @params[:bookmaker_name], @params[:table_name]), @params[:table_name])
     }
    end
  end

  def bookmakers_manager
   # ActiveRecord::Base.logger.info params.inspect
    if signed_in? && current_user.admin?
      @params = params
      @bookmakers = Bookmaker.all
      respond_to do |format|
        format.html {
          @params[:bookmaker_name] = 'Gamebookers'
          @params[:table_name] = 'sport'

          @common_values = bookmaker_values_with_parents Common.where(:table_name => @params[:table_name]), @params[:table_name]
          @values = bookmaker_values_with_parents((bookmaker_values @params[:bookmaker_name], @params[:table_name]), @params[:table_name])
          #@elements = bookmaker_elements_by_common_id(@params[:bookmaker_name], @common_values.first.id)
          #ActiveRecord::Base.logger.info @values.inspect
        }
        format.js {
          if !@params[:element_id].nil?
            @elements = bookmaker_elements_by_common_id(@params[:bookmaker_name], @params[:element_id])
          end
            @common_values = bookmaker_values_with_parents Common.where(:table_name => @params[:table_name]), @params[:table_name]
            @values = bookmaker_values_with_parents((bookmaker_values @params[:bookmaker_name], @params[:table_name]), @params[:table_name])
        }
      end
    end
  end

  def users_manager
    @users = User.all
    @users = User.order(:username).page params[:page]
  end

  def leagues_manager
    @league = League.new
    @sports = Sport.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def pages_manager
    @page = Page.new
    @pages = Page.all
    @pages = Page.order(:name).page params[:page]
  end


  # creation and edition
  def sport_new
    @sport = Sport.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def sport_edit
    @sport = Sport.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def country_new
    @country = Country.new
    @flags = Dir.glob("public/images/flags/*").collect {  |file|  file.gsub("public/images/flags/", "") }
    respond_to do |format|
      format.html
      format.js
    end
  end

  def country_edit
    @country = Country.find( params[:id] )
    @flags = Dir.glob("public/images/flags/*").collect {  |file|  file.gsub("public/images/flags/", "")  }
    respond_to do |format|
      format.html
      format.js
    end
  end

  def league_new
    @league = League.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def league_edit
    @league = League.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end
end

