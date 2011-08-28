class Country < ActiveRecord::Base
  
  attr_accessible :name, :priority, :flag_image
  
  has_many :ligues, :dependent => :destroy 
  
  letters_regex = /[\w\s]+/i 
  numbers_regex = /[0-9]/
  
  validates :name,  :presence => true,
                    :length   => { :within => 2..128},
                    :format   => { :with => letters_regex },
                    :uniqueness => true
  
  default_scope :order => 'countries.priority DESC'
  
end
