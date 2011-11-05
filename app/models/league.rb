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

  #find old elements, interval can be changed
  scope :older_than, lambda { |time| where("updated_at < ?", time) }

  def self.get_countries
    find( :all, :select => "country_id, COUNT(country_id) AS duplicate_count", :conditions => "country_id IS NOT NULL", :group  => "country_id HAVING duplicate_count >= 1")
  end

  def self.get_league_by_country_and_sport( sport_id, country_id )
      where(:sport_id => sport_id, :country_id => country_id)
  end

end

