class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      
      t.string :name
      t.integer :priority
      t.timestamps
      
    end
  end
  
  add_index :teams, :priority
  
  def self.down
    drop_table :teams
  end
end
