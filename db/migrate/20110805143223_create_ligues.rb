class CreateLigues < ActiveRecord::Migration
  def self.up
    create_table :ligues do |t|
      
      t.string :name
      t.integer :team_id
      t.integer :priority
      
      t.timestamps
    end
  end
  
  add_index :ligues, :priority
  add_index :ligues, :team_id
  add_index :ligues, :created_at

  def self.down
    drop_table :ligues
  end
end
