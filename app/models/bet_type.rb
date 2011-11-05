class BetType < ActiveRecord::Base

  attr_accessible :name, :priority

  has_many :bets, :dependent => :destroy

  #find old elements, interval can be changed
  scope :older_than, lambda { |time| where("updated_at < ?", time) }
end

