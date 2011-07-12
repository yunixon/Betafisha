# coding: utf-8
class SiteTopNavigationController < ApplicationController

  def betting
    @title = "Ставки"
  end

  def free_bets
    @title = "Свободные ставки"
  end

  def in_play
    @title = "В игре"
  end

  def tipping
    @title = "Советы"
  end

  def gaming
   @title = "Игры"
  end

  def news
    @title = "Новости"
  end

end
