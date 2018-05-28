class AddImageFileNameToBooks < ActiveRecord::Migration
  def change
    add_column :books, :image_file_name, :string
  end
end
