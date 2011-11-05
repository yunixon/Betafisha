class AddTitleToBookmaker < ActiveRecord::Migration
  def self.up
    add_column :bookmakers, :title, :string
  end

  def self.down
    remove_column :bookmakers, :title
  end
end
