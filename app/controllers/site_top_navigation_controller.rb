# coding: utf-8

class SiteTopNavigationController < ApplicationController
  
  def coefficients
    @title = I18n.t(:top_menu_coefficients)
    redirect_to api_test_path
  end

  def bookmakers
    @title = I18n.t(:top_menu_bookmakers)
  end

  def statistics
    @title = I18n.t(:top_menu_statistics)
  end

  def tools
    @title = I18n.t(:top_menu_ools)
  end

end
