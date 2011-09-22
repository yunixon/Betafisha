class League < ActiveRecord::Base

  attr_accessible :name, :priority, :sport_id, :country_id

  belongs_to :sport
  belongs_to :country
  has_many :coupons
  has_many :events, :dependent => :destroy

  letters_regex = /[\w\s]+/i
  numbers_regex = /[0-9]/

  validates :name,  :presence => true,
                    :length   => { :within => 2..128}

  default_scope :order => 'leagues.priority DESC'

end

