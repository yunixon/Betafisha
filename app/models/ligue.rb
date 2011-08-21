class Ligue < ActiveRecord::Base
  
  attr_accessible :name, :priority, :sport_id, :country_id
  
  belongs_to :sport
  belongs_to :country
  
  has_many :events, :dependent => :destroy 
  
  letters_regex = /[\w\s]+/i 
  numbers_regex = /[0-9]/
  
  validates :name,  :presence => true,
                    :length   => { :within => 2..64},
                    :format   => { :with => letters_regex }
                    
  validates :priority, :presence => true,
                       :length   => { :within => 1..64},
                       :format   => { :with => numbers_regex }
                       
                       
  default_scope :order => 'ligues.priority DESC'
                    
  
end
