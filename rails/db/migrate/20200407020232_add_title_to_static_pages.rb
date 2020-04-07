class AddTitleToStaticPages < ActiveRecord::Migration[5.2]
  def change
    add_column :static_pages, :title, :string
  end
end
