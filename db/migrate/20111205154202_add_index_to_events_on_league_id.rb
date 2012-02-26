class AddIndexToEventsOnLeagueId < ActiveRecord::Migration
  def self.up
    add_index :events, :league_id
  end

  def self.down
    remove_index :events, :league_id
  end
end
