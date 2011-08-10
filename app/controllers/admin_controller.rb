class AdminController < ApplicationController
  
  layout 'admin'
  def index
        
    @sports = Sport.find(:all)
    
    @priorities = {'Низкий' => 1, 'Средний' => 2, 'Высокий' => 3}
    
    @sport = Sport.new if signed_in? && current_user.admin?
    
   #respond_to do |format|
   #  format.html 
   #  format.js 
   #  end 
   
  end
  
  layout 'admin'
  def users_manager
    
  end
  
  layout 'admin' 
  def navigation_manager

  end
  
end
