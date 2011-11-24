module CalculatingName

  MODELS_FOR_TITLE_CHECK = [Event, League, Country, Sport, Participant, BetType, Bookmaker]

  require File.dirname(__FILE__) + "/../config/application"
  Rails.application.require_environment!

  def calculate_name(model, element, type, allownew = true, sport_and_country_and_league = [])
    _name = ''
    if temp = model.find(:first, :conditions => {:element_name => element, :table_name => type})
      _name = temp.common ? temp.common.element_name : temp.element_name
    elsif temp = Common.find(:first, :conditions => ["element_name like :e and table_name = :t", {:e => "%#{element}%", :t => type}])
      model.create(:table_name => type, :element_name => element, :common_id => temp.id)
      _name = temp.element_name
    elsif type == 'league'
      all_leagues = Common.find(:all, :conditions => ["element_name like :e and table_name = :t", {:e => "%#{sport_and_country_and_league[2].rstrip}%", :t => 'league'}])
      all_leagues.each do |l|
        if l.element_name.include?(sport_and_country_and_league[0].rstrip) && l.element_name.include?(sport_and_country_and_league[1].rstrip)
          _name = l.element_name
        end
      end
      if _name.blank?
        model.create(:table_name => type, :element_name => sport_and_country_and_league.join(' | '))
        _name = sport_and_country_and_league.join(' | ')
      end
    elsif allownew
      Common.find(:all, :conditions => {:table_name => type}).each do |s|
        if element.downcase.include? s.element_name.downcase
           model.create(:table_name => type, :element_name => element, :common_id => s.id)
           _name = s.element_name
         end
      end
      unless _name.present?
       # if type == 'country'
       #   element_common_world = Common.find_or_create_by_element_name_and_table_name(:element_name => element, :table_name => type)
       #   model.create(:table_name => type, :element_name => element, :common_id => element_common_world.id)
       #   _name = element
       # else
          model.create(:table_name => type, :element_name => element)
          _name = element
       # end
      end
    end
    return _name
  end

  def calculate_common_name(name, type)
    result = nil
    if temp = Common.find(:first, :conditions => {:element_name => name})
      result = temp
    elsif temp = Common.find(:first, :conditions => ["element_name like :e and table_name = :t", {:e => "%#{name}%", :t => type}])
      if temp.element_name.length > name.length
        temp.update_attribute(:element_name, name)
        result = temp
      end
    else
      Common.find(:all, :conditions => {:table_name => type}).each do |s|
        if name.downcase.include? s.element_name.downcase
          result = s
        end
      end
      result = Common.create(:table_name => type, :element_name => name) unless result
    end
  end

  def set_attribute_unless_given(element, field, value)
    element.send(field).present? ? element.send(field) : value
  end
  
  def check_and_set_titles
    MODELS_FOR_TITLE_CHECK.each do |model|
      model.all.each do |element|
        if model == League 
          if element.title.present?
           element.update_attribute(:title, element.title.split(" | ")[2]) if element.title.split(" | ").length == 3
          else 
            element.update_attribute(:title, element.name.split(" | ")[2]) if element.name.split(" | ").length == 3 
          end # end of presents check
        else
          element.update_attribute(:title, element.name) unless element.title.present?
        end # end of model check
      end
    end
  end

  def check_previous_names(old_name, new_name, parent_model, parent_model_id_symbol, parent_model_id, childrens = [], bookmaker=nil)
    ActiveRecord::Base.logger.info "!!!!!!!" 
    ActiveRecord::Base.logger.info "#{old_name}" 
    ActiveRecord::Base.logger.info "#{new_name}" 
    ActiveRecord::Base.logger.info " NeqO #{ new_name != old_name }"
    ActiveRecord::Base.logger.info "finded #{ parent_model.find(:first, :conditions => ['name = ?', old_name]).present? }"
    ActiveRecord::Base.logger.info parent_model_id
    ActiveRecord::Base.logger.info bookmaker
    ActiveRecord::Base.logger.info "!!!!!!!" 
    if new_name != old_name && parent_model.find(:first, :conditions => ['name = ?', old_name]).present?
      childrens.each do |childs|
        parent_model.find(:first, :conditions => ['name = ?', old_name]).send(childs).each do |l|
          
          #if bookmaker.present?  
            #ActiveRecord::Base.logger.info l.name
            #ActiveRecord::Base.logger.info parent_model.name.downcase
           # ActiveRecord::Base.logger.info bookmaker.find_by_element_name( l.name ).inspect
            l.update_attribute(parent_model_id_symbol, parent_model_id) if bookmaker.find_by_element_name( l.name )
          #else
          #  ActiveRecord::Base.logger.info "else"
          #  l.update_attribute(parent_model_id_symbol, parent_model_id)
         # end
          #l.update_attribute(parent_model_id_symbol, parent_model_id)
          #l.save :validate => false
        end
      end
    end
  end

end

