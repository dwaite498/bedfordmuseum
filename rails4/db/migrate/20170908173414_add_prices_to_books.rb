class AddPricesToBooks < ActiveRecord::Migration
  def change
    add_column :books, :price, :string
    add_column :books, :shipping, :string
    add_column :books, :paypal_link, :string
  end
end
