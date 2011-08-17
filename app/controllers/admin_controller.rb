class AdminController < ApplicationController
  
  layout 'admin'
  def index

  end

  def users_manager
    if signed_in? && current_user.admin?    
      @sports = Sport.all 
      #@countries = sport.ligues.inject({}) do |hash,item|hash[item.name]||=item hash end.values.inspect 
      @users = User.all
      @users = User.order(:name).page params[:page] # .paginate :page => params[:page]
      
    else 
      deny_access
    end  
  end
  
  def sports_manager
    if signed_in? && current_user.admin?    
      @sports = Sport.all 
       
    else 
      deny_access
    end
    
  end 
 
  def sport_new
    if signed_in? && current_user.admin? 
      @sport = Sport.new
      respond_to do |format|
        format.html 
        format.js 
      end 
    end
  end
  
  def sport_edit
   @sport = Sport.find(params[:id]) 
   respond_to do |format|
    format.html 
    format.js 
    end 
    
  end
 
end
