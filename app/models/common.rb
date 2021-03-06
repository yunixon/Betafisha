class Common < ActiveRecord::Base

  has_many :betredking
  has_many :gamebooker
  has_many :stan_jame
  has_many :nordicbets

  validates :element_name, :bookmaker_element => true

  scope :leagues, where(:table_name => 'league')
  scope :sports, where(:table_name => 'sport')
  scope :countries, where(:table_name => 'country')
  scope :events, where(:table_name => 'event')
  scope :bet_types, where(:table_name => 'bet_type')
  scope :participants, where(:table_name => 'participant')
end
