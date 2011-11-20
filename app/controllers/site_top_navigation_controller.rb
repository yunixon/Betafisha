class SiteTopNavigationController < ApplicationController

  include SportsHelper
  caches_action :coefficients, :bookmakers, :statistics, :tools
  
  def coefficients
 	  @sports = Sport.all
  end

  def bookmakers
    @sports = Sport.all
  end

  def statistics
    @sports = Sport.all
  end

  def tools
    @sports = Sport.all
  end

end

