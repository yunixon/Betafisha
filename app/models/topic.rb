class Topic < ActiveRecord::Base

  attr_accessible :name, :content
  belongs_to :forum
  belongs_to :user
  has_many :posts, :dependent => :destroy 

  default_scope :order => 'topics.created_at DESC'

end
