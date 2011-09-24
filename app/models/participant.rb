class Participant < ActiveRecord::Base

  attr_accessible :name, :priority

  belongs_to :event, :dependent => :destroy
  has_many :bets, :dependent => :destroy

  letters_regex = /[\w\s]+/i
  numbers_regex = /[0-9]/

  validates :name,  :presence => true,
                    :length   => { :within => 2..128},
                    :format   => { :with => letters_regex },
                    :uniqueness => true

  #find old elements, interval can be changed
  scope :old, where("updated_at < ?", Time.now - 1.minute)
end
