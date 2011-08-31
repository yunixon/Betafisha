class CreateBetredkings < ActiveRecord::Migration
  def self.up
    create_table :betredkings do |t|
      t.string :table_name
      t.string :element_name
      t.integer :gamebooker_id

      t.timestamps
    end
  end

  def self.down
    drop_table :betredkings
  end
end
