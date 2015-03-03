class AddAnalogInfoToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :film, :string
    add_column :photos, :camera, :string
    add_column :photos, :capture_office, :string
  end
end
