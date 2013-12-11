class AddColumnPublishDateToBook < ActiveRecord::Migration
  def change
    add_column :books, :publish_date,             :date
    add_column :books, :cover_photo_file_name,    :string
    add_column :books, :cover_photo_content_type, :string
    add_column :books, :cover_photo_file_size,    :integer
    add_column :books, :cover_photo_updated_at,   :datetime
  end
end
