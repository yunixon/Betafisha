class Odd < ActiveRecord::Base
  
  attr_accessible :name, :priority
  
  belongs_to :odd_type, :bookmaker, :team, :event
  
end
