class AddTitleToParticipant < ActiveRecord::Migration
  def self.up
    add_column :participants, :title, :string
  end

  def self.down
    remove_column :participants, :title
  end
end
