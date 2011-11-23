# coding: utf-8
class UsersController < ApplicationController

 before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
 before_filter :correct_user, :only => [:edit, :update]
 before_filter :admin_user,   :only => :destroy

  layout 'sign'
  
  def index
    @users = User.all
    @users = User.order(:name).page params[:page]
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.admin?
      flash[:warning] = "You can't delete admin."
      redirect_to :controller=>"admin", :action => "users_manager", :page => params[:page]
   else
      user.destroy
      flash[:success] = "User [" + user.name + "] has been successfully deleted."
      redirect_to :controller=>"admin", :action => "users_manager"
    end
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

end
