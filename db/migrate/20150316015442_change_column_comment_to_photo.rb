class ChangeColumnCommentToPhoto < ActiveRecord::Migration
  def up
  	change_column :photos, :comment, :text
  end

  def down
  	change_column :photos, :comment, :string
  end
end
