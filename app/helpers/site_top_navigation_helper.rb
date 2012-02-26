module SiteTopNavigationHelper

  def imageUriByBookmakerName ( bookmaker_name )
    imageUri = case bookmaker_name
               when "Gamebookers" then "gb.gif"
               when "Betredkings" then "brk.gif"
               when "StanJames"   then "stanjames.gif"
               when "Nordicbets"  then "nordicbet.gif"
            end
  end

  def resource_name
    :user
  end
    def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def menu_item_active? ( menu_item )
    true if action_name == menu_item
  end

end