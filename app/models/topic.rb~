class Topic < ActiveRecord::Base
  attr_accessible :name
  belongs_to :forum
  has_many :posts, :dependent => :destroy 
end
