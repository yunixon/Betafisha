class SportsController < ApplicationController

  before_filter :authenticate, :only => [:edit, :update, :destroy]
  before_filter :admin_user, :only => [:edit, :update, :destroy]

  def index
    @sports = Sport.find(:all)
  end

  def create
    @sport = Sport.create!(params[:sport])
    if @sport.save
      respond_to do |format|
        format.html
        format.js { @sports = Sport.find(:all) }
      end
    end
  end

  def show
    @sports = Sport.all
    @sport = Sport.find(params[:id])
  end

  def edit
    @sport = Sport.find(params[:id])
  end

  def update
    @sport = Sport.find(params[:id])
    @sport.update_attributes(params[:sport])

    respond_to do |format|
      format.html
      format.js { @sports = Sport.find(:all) }
   end

  end

  def destroy
    sport = Sport.find(params[:id])
    sport.destroy
    respond_to do |format|
      format.js { @sports = Sport.find(:all) }
    end
  end

end

