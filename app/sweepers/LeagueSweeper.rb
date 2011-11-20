class LeagueSweeper < ActionController::Caching::Sweeper

  observe League
  
  # If our sweeper detects that a Sport was created call this
  def after_create(league)
    expire_cache_for(league)
  end
 
  # If our sweeper detects that a Sport was updated call this
  def after_update(league)
    expire_cache_for(league)
  end
 
  # If our sweeper detects that a Sport was deleted call this
  def after_destroy(league)
    expire_cache_for(league)
  end
 
  private
  
  def expire_cache_for(league)
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
