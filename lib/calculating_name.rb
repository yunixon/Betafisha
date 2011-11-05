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
      all_leagues = Common.find(:all, :conditions => ["element_name like :e and table_name = :t", {:e => "%#{sport_and_country_and_league[2]}%", :t => 'league'}])
      all_leagues.each do |l|
        if l.element_name.include?(sport_and_country_and_league[0]) && l.element_name.include?(sport_and_country_and_league[1])
          _name = l.element_name
        end
      end
    elsif allownew
      Common.find(:all, :conditions => {:table_name => type}).each do |s|
        if element.downcase.include? s.element_name.downcase
           model.create(:table_name => type, :element_name => element, :common_id => s.id)
           _name = s.element_name
         end
      end
      unless _name.present?
        if type == 'country'
          element_common_world = Common.find(:first, :conditions => {:element_name => 'World', :table_name => 'country'})
          model.create(:table_name => type, :element_name => 'World', :common_id => element_common_world.id)
          _name = 'World'
        else
          model.create(:table_name => type, :element_name => element)
          _name = element
        end
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
        element.update_attribute(:title, element.name) unless element.title.present?
      end
    end
  end
end