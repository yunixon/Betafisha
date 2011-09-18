class CreateNordicbets < ActiveRecord::Migration
  def self.up
    create_table :nordicbets do |t|
      t.string :table_name
      t.string :element_name
      t.integer :common_id

      t.timestamps
    end
  end

  def self.down
    drop_table :nordicbets
  end
end
