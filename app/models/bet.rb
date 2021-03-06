class Bet < ActiveRecord::Base

  attr_accessible :name, :priority

  belongs_to :bet_type
  belongs_to :bookmaker
  belongs_to :event
  belongs_to :participant

  #find old elements, interval can be changed
  scope :older_than, lambda { |time| where("updated_at < ?", time) }


  def self.with_bet_type( name )
    joins(:bet_type).where("bet_types.name = ?", name)
  end

  def self.with_bookmaker_name( name )
    joins(:bet_type).where("bet_types.name = ?", type)
  end

  def self.with_participant_name( name )
    joins(:bet_type).where("bet_types.name = ?", type)
  end

  #filters
  scope :to_win_with_draw, with_bet_type("1x2")
  scope :to_win, with_bet_type("1or2")
  scope :outright, with_bet_type("Outright")


  before_save :verify_the_uniqueness

  private

  def verify_the_uniqueness
    if self.bookmaker == Bookmaker.find(:first, :conditions => ['name = ?', 'StanJames'])
      result = Bet.find(:all, :conditions =>
        {:name => self.name, :bookmaker_id => self.bookmaker_id, :odd => self.odd, :event_id => self.event_id})

      !result.present?
    else
      #validate only for stan james
      true
    end
  end
end

