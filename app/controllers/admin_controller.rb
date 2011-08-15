class AdminController < ApplicationController
  
  
  
  layout 'admin'
  def index

  end

  layout 'admin'
  def users_manager
    if signed_in? && current_user.admin?    
      @sports = Sport.all 
       
      @users = User.all
      @users = User.order(:name).page params[:page] # .paginate :page => params[:page]
      
      
    else 
      deny_access
    end
    
  end
  
  layout 'admin'
  def sports_manager
    if signed_in? && current_user.admin?    
      @sports = Sport.all 
       
    else 
      deny_access
    end
    
  end 


  layout 'admin'
  def sport_new
    if signed_in? && current_user.admin? 
      @sport = Sport.new
      respond_to do |format|
        format.html 
        format.js 
      end 
    end
  end
  
  layout 'admin'
  def sport_edit
   @sport = Sport.find(params[:id]) 
   respond_to do |format|
    format.html 
    format.js 
    end 
    
  end
 
end
