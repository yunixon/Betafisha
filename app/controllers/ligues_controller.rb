class LiguesController < ApplicationController

  before_filter :authenticate
  before_filter :admin_user
  def index
    @ligues = Ligue.find(:all)
  end
  
  def new
    @ligues = Ligue.find(:all)
  end

  def create
    @ligue = Ligue.create!(params[:ligue])
      @success = false
      respond_to do |format|
        format.html
        format.js { 
          if @ligue.save  
            @success = true
            @sports = Sport.find(:all) 
          else 
            @success = false  
            @sports = Sport.find(:all) 
          end 
        }
      end  

  end

  def show
    @ligue = Ligue.find(params[:id])
  end

  def edit
    @ligue = Ligue.find(params[:id])

  end

  def update
    @ligue = Ligue.find(params[:id])
    @ligue.update_attributes(params[:ligue])

    respond_to do |format|
      format.html
      format.js { @sports = Sport.find(:all) }
    end
  end

  def destroy
    ligue = Ligue.find(params[:id])
    
    @sport_id = ligue.sport.id
    @country_id = ligue.country.id
    
    ligue.destroy
    respond_to do |format|
      format.js { @sports = Sport.find(:all) }
    end
  end

end
