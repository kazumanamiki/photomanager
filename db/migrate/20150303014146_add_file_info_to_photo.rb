class AddFileInfoToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :volume, :string
    add_column :photos, :path, :string
    add_column :photos, :file_name, :string
  end
end
