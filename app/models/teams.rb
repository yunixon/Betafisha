# == Schema Information
#
# Table name: teams
#
#  id         :integer(4)      not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Teams < ActiveRecord::Base
  
  attr_accessible :id, :name, :priority
  belongs_to :ligues
  
end
