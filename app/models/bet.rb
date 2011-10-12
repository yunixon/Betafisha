class Bet < ActiveRecord::Base

  attr_accessible :name, :priority

  belongs_to :bet_type
  belongs_to :bookmaker
  belongs_to :event
  belongs_to :participant

  #find old elements, interval can be changed
  scope :old, where("updated_at < ?", Time.now - 1.hour)

  before_save :verify_the_uniqueness


  private

  def verify_the_uniqueness
    if self.bookmaker = Bookmaker.find(:first, :conditions => ['name = ?', 'StanJames'])
      result = Bet.find(:all, :conditions =>
      ['name = ? and bookmaker_id = ? and odd = ? and event_id = ?', self.name, self.bookmaker_id, self.odd, self.event_id])

      return false if result.present?
    end
  end
end
