# == Schema Information
#
# Table name: countries
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Countries < ActiveRecord::Base
  
  attr_accessible :id, :name, :priority
  belongs_to :sports
  has_many :ligues, :dependent => :destroy
  
end
