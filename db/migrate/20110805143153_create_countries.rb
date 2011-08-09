class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      
      t.string  :name
      t.integer :ligue_id
      t.integer :priority
      
      t.timestamps
    end
  end
  
  add_index :countries, :priority
  add_index :countries, :ligue_id
  add_index :countries, :created_at
   
  def self.down
    drop_table :countries
  end
end
