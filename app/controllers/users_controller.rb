# coding: utf-8
class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @title = I18n.t(:top_menu_sing_up)
  end

  def show
    
    @user = User.find(params[:id])
    if signed_in?
      @title = I18n.t(:top_menu_profile) + ": " + @user.name
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      
      UserMailer.registration_confirmation(@user).deliver
   
      flash[:success] = I18n.t(:flash_sing_up_success)
      redirect_to @user
    else
      render 'new'
    end
    
  end
  
  def edit
    
  end

end
