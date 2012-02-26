class Page < ActiveRecord::Base
  paginates_per 5

  attr_accessible :name, :permalink, :content
  belongs_to :page_subject

end
