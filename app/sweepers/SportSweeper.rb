class SportSweeper < ActionController::Caching::Sweeper

  observe Sport
  
  # If our sweeper detects that a Sport was created call this
  def after_create(sport)
    expire_cache_for(sport)
  end
 
  # If our sweeper detects that a Sport was updated call this
  def after_update(sport)
    expire_cache_for(sport)
  end
 
  # If our sweeper detects that a Sport was deleted call this
  def after_destroy(sport)
    expire_cache_for(sport)
  end
 
  private
  
  def expire_cache_for(sport)
    # Expire the index page now that we added a new product
    expire_action :controller => "/admin", :action => "leagues_manager"
    expire_action :controller => "/site_top_navigation", :action => "coefficients"
    expire_action :controller => "/site_top_navigation", :action => "bookmakers"
    expire_action :controller => "/site_top_navigation", :action => "statistics"
    expire_action :controller => "/site_top_navigation", :action => "tools"
    expire_action :controller => "/sports", :action => "show"
    expire_action :controller => "/leagues", :action => "show"
    expire_action :controller => "/countries", :action => "show"
  end

end
