class AddHomePageToStaticPages < ActiveRecord::Migration[5.2]
  def change
    add_column :static_pages, :homepage, :boolean
  end
end
