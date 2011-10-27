class Post < ActiveRecord::Base
  attr_accessible :content
  belongs_to :topic

  default_scope :order => 'posts.created_at DESC'

end
