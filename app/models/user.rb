require "digest"

class User < ActiveRecord::Base

  paginates_per 5

  has_many :posts, :dependent => :destroy
  has_many :topics, :dependent => :destroy
  has_many :coupons
  
    # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :token_authenticatable,
                                               :encryptable, :confirmable, :lockable, :timeoutable, :omniauthable, :encryptor => :sha512

  email_regex = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,3})$/i

  validates :username, 
                    :length   => { :within => 2..15}

  validates :email, :format   => { :with => email_regex },
                    :uniqueness => true

  validates :password,  :confirmation => true, :length => { :within => 6..64}


end
