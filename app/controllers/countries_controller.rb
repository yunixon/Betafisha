# coding: utf-8
class CountriesController < ApplicationController

  before_filter :authenticate
  before_filter :admin_user

  def index
    @countries = Country.find(:all)
  end

  def create
    @country = Country.create!(params[:country])
    if @country.save
     flash[:success] = "Страна [" + @country.name +  "] была успешно добавлена."
     redirect_to sports_manager_path
    end
  end

  def show
    @country = Country.find(params[:id])
  end

  def edit
    @country = Country.find(params[:id])
  end

  def update
    @country = Country.find(params[:id])
    @country.update_attributes(params[:country])
    @league = League.find_by_country_id(@country.id)

    respond_to do |format|
      format.html
      format.js { @sports = Sport.find(:all) }
    end
  end

  def destroy
    country = Country.find(params[:id])
    @league = League.find_by_country_id(@country.id)
    country.destroy
    respond_to do |format|
      format.js { @sports = Sport.find(:all) }
    end
  end

end

