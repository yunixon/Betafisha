class AddLeagueIdToCoupon < ActiveRecord::Migration
  def self.up
    add_column :coupons, :league_id, :integer
  end

  def self.down
    remove_column :coupons, :league_id
  end
end
