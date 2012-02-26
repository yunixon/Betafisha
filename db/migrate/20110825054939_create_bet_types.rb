class CreateBetTypes < ActiveRecord::Migration
  def self.up
    create_table :bet_types do |t|

      t.string  :name
      t.integer :priority

      t.timestamps
    end
  end

  def self.down
    drop_table :bet_types
  end
end
