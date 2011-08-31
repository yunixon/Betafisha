class LeaguesController < ApplicationController

  before_filter :authenticate
  before_filter :admin_user

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
    @league = League.find(params[:id])
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

end
