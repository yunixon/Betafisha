class RemoveTeamIdFromBet < ActiveRecord::Migration
  def self.up
    remove_column :bets, :team_id
  end

  def self.down
    add_column :bets, :team_id, :integer
  end
end
