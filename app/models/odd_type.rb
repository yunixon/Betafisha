class OddType < ActiveRecord::Base
  
  attr_accessible :name, :priority
  
  has_many :odds, :dependent => :destroy 
  
end
