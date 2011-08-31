class Event < ActiveRecord::Base

  attr_accessible :name, :priority
  
  belongs_to :league
  has_many :participants
  
  has_many :bets, :dependent => :destroy 
  
end
