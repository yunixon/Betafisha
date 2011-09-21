class Coupon < ActiveRecord::Base
  belongs_to :user
  has_many :leagues
end

