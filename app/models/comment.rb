class Comment < ActiveRecord::Base

  attr_accessible :content
  belongs_to :user
  belongs_to :news_block

  validates :content, :presence => true,
                    :length   => { :within => 2..256}

   default_scope :order => 'comments.created_at ASC'
end

