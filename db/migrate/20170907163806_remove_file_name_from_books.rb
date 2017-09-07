class RemoveFileNameFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :filename, :string
  end
end
