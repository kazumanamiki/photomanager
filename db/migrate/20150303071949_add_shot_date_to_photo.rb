class AddShotDateToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :shot_date, :string
  end
end
