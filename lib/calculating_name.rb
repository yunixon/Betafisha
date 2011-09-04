module CalculatingName

  require File.dirname(__FILE__) + "/../config/application"
  Rails.application.require_environment!

  def calculate_name(model, element, type)
    if temp = model.find(:first, :conditions => {:element_name => element})
      _name = temp.gamebooker ? temp.gamebooker.element_name : temp.element_name
    elsif temp = Gamebooker.find(:first, :conditions => ["element_name like :e and table_name = :t", {:e => "%#{element}%", :t => type}])
      model.create(:table_name => type, :element_name => element, :gamebooker_id => temp.id)
      _name = temp.element_name
    else
      Gamebooker.all.each do |s|
        if element.downcase.include? s.element_name.downcase
           model.create(:table_name => type, :element_name => element, :gamebooker_id => s.id)
           _name = s.element_name
         end
      end
      unless _name
        model.create(:table_name => type, :element_name => element)
        _name = element
      end
    end
    return _name
  end

end