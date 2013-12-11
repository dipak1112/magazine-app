class AddColumnChapterIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :chapter_id, :integer
    add_column :pages, :page_number, :integer, :default => 0
  end
end
