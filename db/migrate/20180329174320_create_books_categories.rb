class CreateBooksCategories < ActiveRecord::Migration
  def change
    create_table :books_categories do |t|
      t.integer :book_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
