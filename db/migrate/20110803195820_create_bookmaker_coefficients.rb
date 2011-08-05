class CreateBookmakerCoefficients < ActiveRecord::Migration
  def self.up
    create_table :bookmaker_coefficients do |t|
      
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
    
    add_index :bookmaker_coefficients, :bookmaker_id
    add_index :bookmaker_coefficients, :sport_id
    add_index :bookmaker_coefficients, :ligue_id 
    add_index :bookmaker_coefficients, :team_one_id 
    add_index :bookmaker_coefficients, :team_two_id 
    add_index :bookmaker_coefficients, :bet_type_id
    add_index :bookmaker_coefficients, :team_one_coef 
    add_index :bookmaker_coefficients, :team_two_coef 
    add_index :bookmaker_coefficients, :sportsmen_coef
  end

  def self.down
    drop_table :bookmaker_coefficients
  end
end
