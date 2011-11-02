class Post < ActiveRecord::Base
  attr_accessible :content
  belongs_to :topic
  belongs_to :user
  default_scope :order => 'posts.created_at ASC'

end
