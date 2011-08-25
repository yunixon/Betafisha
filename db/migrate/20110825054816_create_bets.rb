class CreateBets < ActiveRecord::Migration
  def self.up
    create_table :bets do |t|
    
      t.string  :name
      t.string  :odd
      
      t.integer :priority
       
      t.integer :bet_type_id
      t.integer :team_id
      t.integer :event_id    
      t.integer :bookmaker_id
      
      t.timestamps
      
    end
  end

  def self.down
    drop_table :bets
  end
end
