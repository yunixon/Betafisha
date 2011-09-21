require "digest"
class User < ActiveRecord::Base
  paginates_per 5

  has_many :comments, :dependent => :destroy
  has_one :coupon

  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  email_regex = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,3})$/i

  validates :name,  :presence => true,
                    :length   => { :within => 2..15}

  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => true

  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..64}


  before_save :encrypt_password

  # user auth
  def has_password? (submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  # reset password
  def send_password_reset
    self.password_reset_token = SecureRandom.base64(13)
    self.password_reset_sent_at = Time.zone.now
    save! false
    UserMailer.reset_password(self).deliver
  end


  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash (string)
      Digest::SHA2.hexdigest(string)
  end



end

