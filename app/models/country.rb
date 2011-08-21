class Country < ActiveRecord::Base
  
  attr_accessible :name, :priority, :flag_image
  
  has_many :ligues, :dependent => :destroy 
  
  letters_regex = /[\w\s]+/i 
  numbers_regex = /[0-9]/
  
  validates :name,  :presence => true,
                    :length   => { :within => 2..64},
                    :format   => { :with => letters_regex },
                    :uniqueness => true
                    
  validates :priority, :presence => true,
                       :length   => { :within => 1..64},
                       :format   => { :with => numbers_regex }
  
  default_scope :order => 'countries.priority DESC'
  
end
