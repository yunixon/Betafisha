class CreateCoupons < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|
      t.timestamps
      t.integer :user_id
    end
  end

  def self.down
    drop_table :coupons
  end
end

