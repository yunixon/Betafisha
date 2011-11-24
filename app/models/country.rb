class Country < ActiveRecord::Base
  
  attr_accessible :name, :priority, :flag_image
  
  has_many :leagues, :dependent => :destroy 
  
  letters_regex = /[\w\s]+/i 
  numbers_regex = /[0-9]/
  
  validates :name,  :presence => true,
                    :length   => { :within => 2..128},
                    :format   => { :with => letters_regex },
                    :uniqueness => true
  
  default_scope :order => 'countries.priority DESC'
  
  #find old elements, interval can be changed
  scope :older_than, lambda { |time| where("updated_at < ?", time) }
  
  def common_value?
    Common.find_by_element_name_and_table_name(self.name, 'country') ? true : false
  end
  
end
