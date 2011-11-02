class ApplicationController < ActionController::Base

  protect_from_forgery

  include SessionsHelper
  include SiteNavigationHelper
  
  #before_filter :set_locale
  
  def set_locale
      I18n.locale = params[:locale]
  end
  
#  def default_url_options( options={} )
#    if I18n.default_locale == "ru"
#      { }
#    else 
#      { :locale => I18n.locale }
#    end
#  end
 
end
