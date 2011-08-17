class CreateOdds < ActiveRecord::Migration
  def self.up
    create_table :odds do |t|
      
      t.string  :name
      t.string  :value
      
      t.integer :priority
       
      t.integer :odd_type_id
      t.integer :team_id
      t.integer :event_id    
      t.integer :bookmaker_id
         
      t.timestamps
    end
  end

  def self.down
    drop_table :odds
  end
end
