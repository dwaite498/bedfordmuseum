class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.boolean :main_page
      t.integer :main_page_index
      t.date :expiration_date

      t.timestamps null: false
    end
  end
end
