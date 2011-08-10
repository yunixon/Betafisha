class Country < ActiveRecord::Base
  
  attr_accessible :name, :priority
  belongs_to :sport
  
  has_many :ligues, :dependent => :destroy 
  
end
