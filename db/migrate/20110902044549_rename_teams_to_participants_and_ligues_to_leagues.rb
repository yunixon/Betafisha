class RenameTeamsToParticipantsAndLiguesToLeagues < ActiveRecord::Migration
  def self.up
    rename_column :bets, :team_id, :participant_id
    rename_column :events, :ligue_id, :league_id
  end

  def self.down
    rename_column :bets, :participant_id, :team_id
    rename_column :events, :league_id, :ligue_id
  end
end
