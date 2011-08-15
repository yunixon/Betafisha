class SessionsController < ApplicationController
  
  def new
    @title = I18n.t(:top_menu_sign_in)
  end

  def create
     user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:warning] = I18n.t(:flash_sing_up_failed)
      @title = I18n.t(:top_menu_sign_in)
      render 'new'
    else
      sign_in user
      if user.admin?  
        redirect_to admin_path 
      else
        redirect_to user
      end
      
    end 
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
