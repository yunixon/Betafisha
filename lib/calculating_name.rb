module CalculatingName

  require File.dirname(__FILE__) + "/../config/application"
  Rails.application.require_environment!

  def calculate_name(model, element, type, allownew = true)
    _name = ''
    if temp = model.find(:first, :conditions => {:element_name => element, :table_name => type})
      _name = temp.common ? temp.common.element_name : temp.element_name
    elsif temp = Common.find(:first, :conditions => ["element_name like :e and table_name = :t", {:e => "%#{element}%", :t => type}])
      model.create(:table_name => type, :element_name => element, :common_id => temp.id)
      _name = temp.element_name
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
        else
          model.create(:table_name => type, :element_name => element)
          _name = element
        end
      end
    end
    return _name
  end

end