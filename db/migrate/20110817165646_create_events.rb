class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|

      t.string   :name
      t.integer  :priority
      t.string   :date
      t.string   :time

      t.integer :ligue_id

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
