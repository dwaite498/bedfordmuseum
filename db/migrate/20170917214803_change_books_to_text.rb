class ChangeBooksToText < ActiveRecord::Migration
  def change
    change_column :books, :paypal_link, :text
  end
end
