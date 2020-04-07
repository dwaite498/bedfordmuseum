class AddHomePageToStaticPages < ActiveRecord::Migration[5.2]
  def change
    add_column :static_pages, :homepage, :boolean, null: false, default: false
  end
end
