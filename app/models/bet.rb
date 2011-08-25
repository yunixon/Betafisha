class Bet < ActiveRecord::Base

  attr_accessible :name, :priority
  
  belongs_to :bet_type 
  belongs_to :bookmaker 
  belongs_to :team 
  belongs_to :event

end
