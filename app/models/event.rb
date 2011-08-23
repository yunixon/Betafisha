class Event < ActiveRecord::Base
  attr_accessible :name, :priority #, :date, :time
  
  belongs_to :ligue
  
  has_many :odds, :dependent => :destroy 
  
end
