class CreateBookmakerCoefficients < ActiveRecord::Migration
  def self.up
    create_table :bookmaker_coefficients do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :bookmaker_coefficients
  end
end
