class AddIndexToParticipantsOnEventId < ActiveRecord::Migration
  def self.up
    add_index :participants, :event_id
  end

  def self.down
    remove_index :participants, :event_id
  end
end
