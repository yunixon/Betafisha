class CreateNewsBlocks < ActiveRecord::Migration
  def self.up
    create_table :news_blocks do |t|
      t.string :title
      t.text :content
      t.string :image
      t.timestamps
    end
  end

  def self.down
    drop_table :news_blocks
  end
end
