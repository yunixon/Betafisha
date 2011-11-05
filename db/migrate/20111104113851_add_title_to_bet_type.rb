class AddTitleToBetType < ActiveRecord::Migration
  def self.up
    add_column :bet_types, :title, :string
  end

  def self.down
    remove_column :bet_types, :title
  end
end
