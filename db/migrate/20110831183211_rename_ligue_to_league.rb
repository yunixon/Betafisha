class RenameLigueToLeague < ActiveRecord::Migration
  def self.up
    rename_table :ligues, :leagues
  end

  def self.down
    rename_table :leagues, :ligues
  end
end
