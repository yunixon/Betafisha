class CountrySweeper < ActionController::Caching::Sweeper

  observe Country
  
  # If our sweeper detects that a Sport was created call this
  def after_create(country)
    expire_cache_for(country)
  end
 
  # If our sweeper detects that a Sport was updated call this
  def after_update(country)
    expire_cache_for(country)
  end
 
  # If our sweeper detects that a Sport was deleted call this
  def after_destroy(country)
    expire_cache_for(country)
  end
 
  private
  
  def expire_cache_for(country)
    # Expire the index page now that we added a new product
    expire_fragment('all_available_leagues')
  end
  
end
