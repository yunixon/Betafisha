class Ligue < ActiveRecord::Base
  
  attr_accessible :name, :priority
  
  belongs_to :sport
  belongs_to :country
  
end
