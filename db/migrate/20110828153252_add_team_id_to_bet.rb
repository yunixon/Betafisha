class AddTeamIdToBet < ActiveRecord::Migration
  def self.up
    add_column :bets, :team_id, :integer
  end

  def self.down
    remove_column :bets, :team_id
  end
end
