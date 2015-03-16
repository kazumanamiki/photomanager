class AddShotTimeToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :shot_time, :string
  end
end
