class AddIndexToBetsOnBetTypeIdAndEventIdAndBookmakerIdAndParticipantId < ActiveRecord::Migration
  def self.up
    add_index :bets, :bet_type_id
    add_index :bets, :bookmaker_id
    add_index :bets, :participant_id
    add_index :bets, :event_id
  end

  def self.down
    remove_index :bets, :bet_type_id
    remove_index :bets, :bookmaker_id
    remove_index :bets, :participant_id
    remove_index :bets, :event_id
  end
end
