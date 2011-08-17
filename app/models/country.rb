class Country < ActiveRecord::Base
  
  attr_accessible :name, :priority, :flag_image
  
  has_many :ligues, :dependent => :destroy 
  

  
end
