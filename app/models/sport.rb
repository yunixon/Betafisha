class Sport < ActiveRecord::Base
  
  attr_accessible :name, :priority, :logo_image

  has_many :leagues, :dependent => :destroy 
  
  letters_regex = /[\w\s]+/i 
  numbers_regex = /[0-9]/
  
  validates :name,  :presence => true,
                    :length   => { :within => 2..128},
                    :format   => { :with => letters_regex },
                    :uniqueness => true
                       
  default_scope :order => 'sports.priority DESC'
  #find old elements, interval can be changed
  scope :old, where("updated_at < ?", Time.now - 1.minute)
end
