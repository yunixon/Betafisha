class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      
      t.string   :name
      t.integer  :priority
     # t.datetime :date
     # t.time  :time
      
      t.integer :ligue_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
