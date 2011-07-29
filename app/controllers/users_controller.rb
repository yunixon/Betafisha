# coding: utf-8
class UsersController < ApplicationController
  
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  layout 'admin'
  def index
    @users = User.all
    @users = User.paginate(:page => params[:page]) 
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
  
  def destroy
    user = User.find(params[:id])
    if user.admin? && params[:id] == '1' 
      flash[:success] = "You cant delete root admin."
      redirect_to users_path
    else 
      user.destroy
      flash[:success] = "User has been successfully deleted."
      redirect_to users_path
    end
  end
  
   private
   
    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
