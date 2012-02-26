class AddIndexToLeaguesOnCountryIdAndSportId < ActiveRecord::Migration
  def self.up
    add_index :leagues, :country_id
    add_index :leagues, :sport_id
  end

  def self.down
    remove_index :leagues, :country_id
    remove_index :leagues, :sport_id
  end
end
