class RemoveImageFileNameFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :image_file_name, :string
  end
end
