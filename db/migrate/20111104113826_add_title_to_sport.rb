class AddTitleToSport < ActiveRecord::Migration
  def self.up
    add_column :sports, :title, :string
  end

  def self.down
    remove_column :sports, :title
  end
end
