class RenameGamebookerToCommon < ActiveRecord::Migration
  def self.up
    rename_table :gamebookers, :commons
  end

  def self.down
    rename_table :commons, :gamebookers
  end
end
