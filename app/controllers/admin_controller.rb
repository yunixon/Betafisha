class AdminController < ApplicationController
  
  layout 'admin'
  def index
    
  end
  
  layout 'admin'
  def users_manager
    
  end
  
  layout 'admin' 
  def navigation_manager
    
    @sports = Sports.find(:all)
   
  end
  
end
