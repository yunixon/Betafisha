# coding: utf-8
# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require "digest"

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  validates_presence_of :email, :message => "Необходимо указать адрес электронной почты!"
  validates_size_of :name, :within => 2..15, :message => "Пароль должен содержать не менее 2 и не более 15 знаков."
  validates_size_of :password, :within => 6..40, :message => "Пароль должен содержать не менее 6 и не более 40 знаков. Без пробелов." 
  validates_confirmation_of :password, :message => "Необходимо подтвердить пароль!"

  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Не верный формат адреса электронной почты!"

  before_save :encrypt_password

  def has_password? (submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
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
