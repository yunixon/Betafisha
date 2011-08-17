class Odd < ActiveRecord::Base
  
  attr_accessible :name, :priority
  
  belongs_to :odd_type 
  belongs_to :bookmaker 
  belongs_to :team 
  belongs_to :event
  
end
