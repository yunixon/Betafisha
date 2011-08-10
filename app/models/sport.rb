class Sport < ActiveRecord::Base
  
  attr_accessible :name, :priority
  has_many :countries, :dependent => :destroy 
  
end
