class StanJame < ActiveRecord::Base
  belongs_to :common
  validates :element_name, :bookmaker_element => true
  scope :leagues, where(:table_name => 'league')
  scope :sports, where(:table_name => 'sport')
  scope :countries, where(:table_name => 'country')
  scope :events, where(:table_name => 'event')
end
