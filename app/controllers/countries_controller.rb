# coding: utf-8
class CountriesController < ApplicationController

  before_filter :authenticate, :only => [:edit, :update, :destroy]
  before_filter :admin_user, :only => [:edit, :update, :destroy]

  #cache_sweeper :country_sweeper unless Rails.env.development?

  include CalculatingName

  def index
    @countries = Country.find(:all)
  end

  def create
    @country = Country.create!(params[:country])
    if @country.save
     Common.find_or_create_by_element_name_and_table_name(params[:country][:name], 'country')
     flash[:success] = "Страна [" + @country.name +  "] была успешно добавлена."
     redirect_to leagues_manager_path
   end

 end

 def show
  @sports = Sport.all
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
