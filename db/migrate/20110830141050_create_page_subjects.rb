class CreatePageSubjects < ActiveRecord::Migration
  def self.up
    create_table :page_subjects do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :page_subjects
  end
end
