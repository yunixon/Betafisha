# == Schema Information
#
# Table name: ligues
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Ligues < ActiveRecord::Base
  
  attr_accessible :id, :name, :priority
  belongs_to :countries
  has_many :teams, :dependent => :destroy
  
end
