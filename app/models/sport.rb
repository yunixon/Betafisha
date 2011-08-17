class Sport < ActiveRecord::Base
  
  attr_accessible :name, :priority, :logo_image

  has_many :ligues, :dependent => :destroy 
  
end
