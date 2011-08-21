class CreateGameBookersOdds < ActiveRecord::Migration
  def self.up
    create_table :game_bookers_odds do |t|
     
      t.string  :table_name
      t.integer :betafisha_id
      t.integer :gamebookers_id
      t.string  :name

      t.timestamps
    end
  end

  def self.down
    drop_table :game_bookers_odds
  end
end
