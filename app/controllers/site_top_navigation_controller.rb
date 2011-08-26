# coding: utf-8

class SiteTopNavigationController < ApplicationController
  
  def coefficients
    @title = I18n.t(:top_menu_coefficients)
    redirect_to api_test_path
  end

  def bookmakers
    @title = I18n.t(:top_menu_bookmakers)
    @page = Page.find_by_permalink ( 'bookmakers' )
  end

  def statistics
    @title = I18n.t(:top_menu_statistics)
    @page = Page.find_by_permalink ( 'statistics' )
  end

  def tools
    @title = I18n.t(:top_menu_ools)
     @page = Page.find_by_permalink ( 'tools' )
  end

end
