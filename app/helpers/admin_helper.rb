module AdminHelper

  def bookmaker_values (bookmaker_name, table_name)
    values = case bookmaker_name
               when "Gamebookers" then Gamebooker.where(:table_name => table_name)
               when "Betredkings" then Betredking.where(:table_name => table_name)
               when "StanJames" then StanJame.where(:table_name => table_name)
               when "Nordicbets" then Nordicbet.where(:table_name => table_name)
               else "empty"
             end
  end

  def bookmaker_values_with_parents (bookmaker_values, table_name)
    values = case table_name
               when "league" then
                 bookmaker_values.collect { |x| {'id' => x.id,
                                                 'element_name' => # League.find_by_name( x.element_name ) != nil ?
                                                                   # League.find_by_name( x.element_name ).sport.name + " > " +  x.element_name : # find_sport_name_by_common_id( x.common_id ) + " < " +
                                                     x.element_name} }
               when "sport" then bookmaker_values #.collect   { |x| x.element_name   }
               when "country" then bookmaker_values #.collect { |x| x.element_name   }
               when "event" then bookmaker_values #.collect   { |x| x.element_name   }
               when "bet_type" then bookmaker_values #.collect   { |x| x.element_name   }
               when "participant" then bookmaker_values #.collect   { |x| x.element_name   }
               else "empty"
             end
  end

  def bookmaker_elements_by_common_id ( bookmaker_name, common_id )
    values = case bookmaker_name
               when "Gamebookers" then Gamebooker.where( :common_id => common_id )
               when "Betredkings" then Betredking.where( :common_id => common_id )
               when "StanJames" then StanJame.where( :common_id => common_id )
               when "Nordicbets" then Nordicbet.where( :common_id => common_id )
               else "empty"
             end
  end

  def bookmaker_element_by_id ( bookmaker_name, element_id )
    value = case bookmaker_name
               when "Gamebookers" then Gamebooker.find( element_id )
               when "Betredkings" then Betredking.find( element_id )
               when "StanJames" then StanJame.find( element_id )
               when "Nordicbets" then Nordicbet.find( element_id )
               else "empty"
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

