class BetType < ActiveRecord::Base

  attr_accessible :name, :priority
  
  has_many :bets, :dependent => :destroy 

end
