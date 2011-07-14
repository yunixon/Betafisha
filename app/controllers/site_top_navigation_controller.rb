# coding: utf-8
class SiteTopNavigationController < ApplicationController

  def betting
    @title = I18n.t(:top_menu_bettings)
  end

  def free_bets
    @title = I18n.t(:top_menu_free_bets)
  end

  def in_play
    @title = I18n.t(:top_menu_in_play)
  end

  def tipping
    @title = I18n.t(:top_menu_tipping)
  end

  def gaming
   @title = I18n.t(:top_menu_gaming)
  end

  def news
    @title = I18n.t(:top_menu_news)
  end

end
