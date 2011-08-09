class CreateSports < ActiveRecord::Migration
  def self.up
    create_table :sports do |t|
      
      t.string :name
      t.integer :priority
      t.integer :country_id
      t.timestamps
      
    end
  end
  
  add_index :sports, :priority
  add_index :sports, :country_id
  add_index :sports, :created_at

  def self.down
    drop_table :sports
  end
end
