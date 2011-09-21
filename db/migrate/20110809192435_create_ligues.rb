class CreateLigues < ActiveRecord::Migration
  def self.up
    create_table :ligues do |t|

      t.string  :name
      t.integer :priority

      t.integer :country_id
      t.integer :sport_id
      t.integer :coupon_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ligues
  end
end

