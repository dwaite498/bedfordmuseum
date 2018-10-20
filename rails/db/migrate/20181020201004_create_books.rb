class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :author
      t.decimal :price, precision: 8, scale: 2
      t.decimal :shipping, precision: 8, scale: 2
      t.string :paypal_link

      t.timestamps
    end
  end
end
