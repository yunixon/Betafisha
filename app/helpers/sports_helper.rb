module SportsHelper

  def get_common_sports
    return Sport.all
  end

  def get_sport_image( sport )
    image = case sport
      when 'Basketball'         then "http://www.nordicbet.com/photos/50000001308.png"
      when 'Football'           then "http://www.nordicbet.com/photos/50000001417.png"
      when 'Ice Hockey'         then "http://www.nordicbet.com/photos/50000000885.png"
      when 'Tennis'             then "http://www.nordicbet.com/photos/50000001298.png"
      when 'American Football'  then "http://www.nordicbet.com/photos/50000001304.png"
      when 'Floorball'          then "http://www.nordicbet.com/photos/50000001298.png"
      when 'Volleyball'         then "http://www.nordicbet.com/photos/50000001302.png"
      when 'Baseball'           then "http://www.nordicbet.com/photos/50000001310.png"
      when 'Rugby'              then "http://www.nordicbet.com/photos/50000001320.png"
      when 'Handball'           then "http://www.nordicbet.com/photos/50000001322.png"
      else "empty"
    end
  end
  
  def set_common_class ( element )
     'common' if element.common_value?
  end

end

