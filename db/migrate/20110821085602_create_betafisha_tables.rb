class CreateBetafishaTables < ActiveRecord::Migration
  def self.up
    create_table :betafisha_tables do |t|
      
      t.string             :bookmaker_id
      t.string             :sport_id
      t.string             :ligue_id 
      t.string             :team_one_id 
      t.string             :team_two_id
      t.string             :sportsmen_id
      t.string             :bet_type_id
      t.string             :team_one_coef 
      t.string             :team_two_coef 
      t.string             :sportsmen_coef
      
      t.timestamps
    end
  end

  def self.down
    drop_table :betafisha_tables
  end
end
