class Ligue < ActiveRecord::Base
  
  attr_accessible :name, :priority, :sport_id, :country_id
  
  belongs_to :sport
  belongs_to :country
  
  has_many :events, :dependent => :destroy 
  
end
