# == Schema Information
#
# Table name: sports
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Sports < ActiveRecord::Base
  attr_accessible :id, :name
end
