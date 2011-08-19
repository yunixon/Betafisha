class CreateOddTypes < ActiveRecord::Migration
  def self.up
    create_table :odd_types do |t|
      
      t.string  :name
      t.integer :priority
      
      t.timestamps
    end
  end

  def self.down
    drop_table :odd_types
  end
end