class RenameGamebookerIdToCommonId < ActiveRecord::Migration
  def self.up
    rename_column :betredkings, :gamebooker_id, :common_id
  end

  def self.down
    rename_column :betredkings, :common_id, :gamebooker_id
  end
end
