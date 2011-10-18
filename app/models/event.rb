class Event < ActiveRecord::Base

  attr_accessible :name, :priority, :league_id

  belongs_to :league
  has_many :participants

  has_many :bets, :dependent => :destroy

  def self.to_win_with_draw (bet_type, l_id)
    find_by_sql [("SELECT e.* FROM events e INNER JOIN leagues l ON l.id = e.league_id INNER JOIN bets b ON e.id = b.event_id INNER JOIN bet_types bt ON b.bet_type_id = bt.id WHERE bt.name = ? and l.id = ? GROUP BY e.name"), bet_type, l_id]
  end
#def self.find_by_first_letter(letter = "A")
 #     find_by_sql ["select * from artists where ucase(left(artist_name, 1)) = ?", letter]
 #  end
  #scope :to_win_with_draw, with_bet_type("1x2")    #joins(:bets) & Bet.to_win_with_draw

  #find old elements, interval can be changed
  scope :old, where("updated_at < ?", Time.now - 1.hour)

end


#SELECT * FROM events e INNER JOIN bets b ON e.id = b.event_id INNER JOIN bet_types bt ON b.bet_type_id = bt.id WHERE bt.name = '1x2'

