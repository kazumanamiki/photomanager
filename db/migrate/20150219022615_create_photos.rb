class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :number
      t.string :place
      t.string :lens

      t.timestamps null: false
    end
  end
end
