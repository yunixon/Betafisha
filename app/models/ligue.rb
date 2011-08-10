class Ligue < ActiveRecord::Base
  
  attr_accessible :name, :priority
  belongs_to :country
  
end
