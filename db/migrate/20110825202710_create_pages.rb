class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :name
      t.string :permalink
      t.text :content
      t.integer :page_subject_id
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
