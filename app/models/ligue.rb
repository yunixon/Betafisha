class Ligue < ActiveRecord::Base
  
  attr_accessible :name, :priority
  
  belongs_to :sport
  belongs_to :country
  
  has_many :events, :dependent => :destroy 
  
end
