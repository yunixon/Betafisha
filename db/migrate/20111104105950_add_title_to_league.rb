class AddTitleToLeague < ActiveRecord::Migration
  def self.up
    add_column :leagues, :title, :string
  end

  def self.down
    remove_column :leagues, :title
  end
end
