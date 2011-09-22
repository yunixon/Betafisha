class Bookmaker < ActiveRecord::Base
  
  attr_accessible :name, :priority
  
  has_many :bets, :dependent => :destroy 

  #find old elements, interval can be changed
  scope :old, where("updated_at < ?", Time.now - 24.hours)
end
