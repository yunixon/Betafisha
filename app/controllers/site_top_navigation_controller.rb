# coding: utf-8

include SportsHelper

class SiteTopNavigationController < ApplicationController

  def coefficients
     #@title = I18n.t(:top_menu_coefficients)
     @news_blocks = NewsBlock.all(:limit => 5)
     @counter = NewsBlock.all.count
 	   @sports = Sport.all

 	   ActiveRecord::Base.logger.info get_common_sports.inspect
  end

  def bookmakers
    #@title = I18n.t(:top_menu_bookmakers)
    @sports = Sport.all
  end

  def statistics
    #@title = I18n.t(:top_menu_statistics)
    @sports = Sport.all
  end

  def tools
   # @title = I18n.t(:top_menu_ools)
    @sports = Sport.all
  end

end

