class Event < ActiveRecord::Base

  attr_accessible :name, :priority
  
  belongs_to :league
  has_many :participants
  
  has_many :bets, :dependent => :destroy 
  
  #find old elements, interval can be changed
  scope :old, where("updated_at < ?", Time.now - 1.hour)
end
