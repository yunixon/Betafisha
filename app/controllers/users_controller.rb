# coding: utf-8
class UsersController < ApplicationController

  def new
    @user = User.new
    @title = I18n.t(:top_menu_sing_up)
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = I18n.t(:flash_sing_up_success)
      redirect_to @user
    else
      #@title = I18n.t(:top_menu_sing_up)
      render :action => "new"
    end
  end

end