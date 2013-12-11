class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :name
      t.integer :chapter_no
      t.integer :book_id
      t.integer :chapter_start
      t.integer :chapter_end
      t.timestamps
    end
  end
end
