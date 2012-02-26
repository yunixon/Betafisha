# coding: utf-8
class SportsController < ApplicationController

  before_filter :authenticate, :only => [:edit, :update, :destroy]
  before_filter :admin_user, :only => [:edit, :update, :destroy]

  #cache_sweeper :sport_sweeper unless Rails.env.development?

  def index
    @sports = Sport.all
  end

  def create
    @sport = Sport.create!(params[:sport])
    if @sport.save
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def show
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
      format.js
    end
  end

  def destroy
    sport = Sport.find(params[:id])
    sport.destroy
    respond_to do |format|
      format.html
      format.js
    end
  end

end

