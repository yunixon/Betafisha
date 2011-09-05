class PagesController < ApplicationController

  before_filter :admin_user, :only => [:index, :edit, :update, :destroy]
  uses_tiny_mce
  
  
  def coefficients
  
  end
  
  
  def index
    @pages = Page.all
  end

  def show
  	if params[:permalink]
    	@page = Page.find_by_permalink(params[:permalink])
  	else 
    	@page = Page.find(params[:id])
    end
    # !!!
     @sports = Sport.all
     
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])
    @page.page_subject_id = params[:page][:page_subject_id]
    
    if @page.save
    	redirect_to admin_pages_manager_path, :notice => "Successfully created page."
  		#    redirect_to @page, :notice => "Successfully created page."
 		#   else
  		#    render :action => 'new'
    end
  end

  def edit
  @sports = Sport.all
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      redirect_to admin_pages_manager_path, :notice  => "Successfully updated page."
   # else
   #   render :action => 'edit'
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to admin_pages_manager_path, :notice => "Successfully destroyed page."
  end
end
