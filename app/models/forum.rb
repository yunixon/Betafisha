class Forum < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :topics, :dependent => :destroy 

  default_scope :order => 'forums.created_at DESC'
end
