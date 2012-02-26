module AdminHelper

  include CalculatingName

  def exchange_element_relation(info, status)
    bookmaker_element = bookmaker_element_by_id( info[:bookmaker_name], info[:bookmaker_element_id] ) if info
    if bookmaker_element
      bookmaker = bookmaker_model_by_name(info[:bookmaker_name])
      old_name = (status == "create" ? bookmaker_element.element_name : bookmaker_element.common.element_name)
      if status == 'create'
        bookmaker_element.update_attribute( :common_id, info[:common_element_id] )
      elsif status == 'remove'
        bookmaker_element.update_attribute(:common_id, nil)
      end
      if info[:table_name] == "country"
        country = ( status == "create" ? Country.find_by_name(bookmaker_element.common.element_name) : Country.find_by_name(bookmaker_element.element_name) )
        check_previous_names( old_name, country.name , Country, :country_id, country.id, [:leagues], true, bookmaker) if country and old_name
      elsif info[:table_name] == "league"
        league = ( status == "create" ? League.find_by_name(bookmaker_element.common.element_name) : League.find_by_name(bookmaker_element.element_name) )
        check_previous_names( old_name, league.name, League, :league_id, league.id,[:events, :coupons], true, bookmaker ) if league and old_name
      end
    end
  end

  def bookmaker_model_by_name (bookmaker_name)
    values = case bookmaker_name
    when "Gamebookers"  then Gamebooker
    when "Betredkings"  then Betredking
    when "StanJames"    then StanJame
    when "Nordicbets"   then Nordicbet
    else nil
    end
  end

  def bookmaker_values (bookmaker_name, table_name)
    values = case bookmaker_name
    when "Gamebookers"  then Gamebooker.where(:table_name => table_name).order("element_name asc")
    when "Betredkings"  then Betredking.where(:table_name => table_name).order("element_name asc")
    when "StanJames"    then StanJame.where(:table_name => table_name).order("element_name asc")
    when "Nordicbets"   then Nordicbet.where(:table_name => table_name).order("element_name asc")
    else "empty"
    end
  end

  def bookmaker_elements_by_common_id ( bookmaker_name, common_id )
    values = case bookmaker_name
    when "Gamebookers"  then Gamebooker.where( :common_id => common_id ).order("element_name asc")
    when "Betredkings"  then Betredking.where( :common_id => common_id ).order("element_name asc")
    when "StanJames"    then StanJame.where( :common_id => common_id ).order("element_name asc")
    when "Nordicbets"   then Nordicbet.where( :common_id => common_id ).order("element_name asc")
    else "empty"
    end
  end

  def bookmaker_element_by_id ( bookmaker_name, element_id )
    value = case bookmaker_name
    when "Gamebookers"  then Gamebooker.find( element_id )
    when "Betredkings"  then Betredking.find( element_id )
    when "StanJames"    then StanJame.find( element_id )
    when "Nordicbets"   then Nordicbet.find( element_id )
    else "empty"
    end
  end

  def change_element_relation( tableName, elementId )
    value = case tableName
    when "sport"        then Sport.find( elementId )
    when "country"      then Country.find( elementId )
    when "league"       then League.find( elementId )
    when "participant"  then Participant.find( elementId )
    when "event"        then Event.find( elementId )
    when "bet_type"     then BetType.find( elementId )
    when "bet"          then Bet.find( elementId )
    else "empty"
    end
  end

  def bookmaker_values_with_parents (bookmaker_values, table_name, term=nil)
    values = case table_name
    when "league"      then term.nil? ? bookmaker_values.order("element_name asc") : bookmaker_values.order("element_name asc").where("element_name like ?", "%#{term}%")             #.collect { |x| {'id' => x.id, 'element_name' => x.element_name} }
    when "sport"       then term.nil? ? bookmaker_values.order("element_name asc") : bookmaker_values.order("element_name asc").where("element_name like ?", "%#{term}%")
    when "country"     then term.nil? ? bookmaker_values.order("element_name asc") : bookmaker_values.order("element_name asc").where("element_name like ?", "%#{term}%")
    when "event"       then term.nil? ? bookmaker_values.order("element_name asc") : bookmaker_values.order("element_name asc").where("element_name like ?", "%#{term}%")
    when "bet_type"    then term.nil? ? bookmaker_values.order("element_name asc") : bookmaker_values.order("element_name asc").where("element_name like ?", "%#{term}%")
    when "participant" then term.nil? ? bookmaker_values.order("element_name asc") : bookmaker_values.order("element_name asc").where("element_name like ?", "%#{term}%")
    else "empty"
    end
  end

  def show_menu_controlls?
    if controller_name == 'site_top_navigation'
      false
    elsif ['sports', 'leagues', 'countries'].include?(controller_name) and ['index', 'show'].include?(action_name)
      false
    else
      true
    end
  end

  def find_sport_name_by_common_id (id)
    if !Common.find(id).nil?
      if !League.find_by_name(Common.find(id).element_name).nil?
        sport = League.find_by_name(common_name).sport.name
      end
    end
    return sport ||= ""
  end

end