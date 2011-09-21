module SiteTopNavigationHelper

  def imageUriByBookmakerName ( bookmaker_name )
    imageUri = case bookmaker_name
               when "Gamebookers" then "gb.gif"
               when "Betredkings" then "brk.gif"
               when "StanJames"   then "stanjames.gif"
               when "Nordicbets"  then "nordicbet.gif"
            end
  end

end

