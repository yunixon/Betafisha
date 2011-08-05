class CreateLigues < ActiveRecord::Migration
  def self.up
    create_table :ligues do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :ligues
  end
end
