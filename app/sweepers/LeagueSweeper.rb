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
    expire_fragment('all_available_leagues')
  end

end
