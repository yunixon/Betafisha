class RemoveTeamIdFromEvent < ActiveRecord::Migration
  def self.up
    remove_column :events, :team_id
  end

  def self.down
    add_column :events, :team_id, :integer
  end
end
