class NewsBlock < ActiveRecord::Base
  attr_accessible :title, :content, :image, :remote_image_url
  mount_uploader :image, ImageUploader
  
  default_scope :order => 'news_blocks.created_at DESC'
end
