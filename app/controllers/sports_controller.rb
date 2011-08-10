class SportsController < ApplicationController
  
  
  def new
    @sport = Sport.new
  end
  
  
  def index
    @sports = Sport.find(:all)
  end
  
  
  def create
    @sport = Sport.create!(params[:sport])

    respond_to do |format|
       format.html {
          if @sport.save
            redirect_to admin_path
          end
       }
       
       format.js { @sports = Sport.find(:all) } 
       
     end 
  end
  
  def show
    @sport = Sport.find(params[:id])
  end
  
  def update
    @sport = Sport.find(params[:id])
    @sport.update_attributes(params[:sport])
  end
  
  
  def destroy
    sport = Sport.find(params[:id])
    sport.destroy
    respond_to do |format|
      format.js { @sports = Sport.find(:all) }
    end
  end
  
  
  
end
