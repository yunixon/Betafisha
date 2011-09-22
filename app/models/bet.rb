class Bet < ActiveRecord::Base

  attr_accessible :name, :priority

  belongs_to :bet_type
  belongs_to :bookmaker
  belongs_to :event
  belongs_to :participant
  
  #find old elements, interval can be changed
  scope :old, where("updated_at < ?", Time.now - 24.hours)
end
