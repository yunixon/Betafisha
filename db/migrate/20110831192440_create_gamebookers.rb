class CreateGamebookers < ActiveRecord::Migration
  def self.up
    create_table :gamebookers do |t|
      t.string :table_name
      t.string :element_name

      t.timestamps
    end
  end

  def self.down
    drop_table :gamebookers
  end
end
