module SessionsHelper

  def authenticate
    deny_access unless user_signed_in?
  end

  def admin_user
    deny_access unless current_user.admin?
  end

  def deny_access
    redirect_to user_session_path, :notice => "Please sign in to access this page."
  end

  def current_user?(user)
    user == current_user
  end
  
  def admin_signed_in?
    user_signed_in? && current_user.admin?
  end

end

