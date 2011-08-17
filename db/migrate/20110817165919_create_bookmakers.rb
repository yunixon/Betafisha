class CreateBookmakers < ActiveRecord::Migration
  def self.up
    create_table :bookmakers do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :bookmakers
  end
end
