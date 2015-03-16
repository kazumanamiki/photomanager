class AddMd5andFileSizeToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :md5, :string
    add_column :photos, :file_size, :integer
  end
end
