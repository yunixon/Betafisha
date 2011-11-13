require "digest"

class User < ActiveRecord::Base

  paginates_per 5

  has_many :posts, :dependent => :destroy
  has_many :topics, :dependent => :destroy
  has_many :coupons
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable, :omniauthable,   :encryptor => :sha512

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me
end
