class RenameTeamToParticipant < ActiveRecord::Migration
  def self.up
    rename_table :teams, :participants
  end

  def self.down
    rename_table :participants, :teams
  end
end
