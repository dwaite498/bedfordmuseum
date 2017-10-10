class CreateIndexitems < ActiveRecord::Migration
  def change
    create_table :indexitems do |t|
      t.string :title
      t.text :paragraph
      t.string :link

      t.timestamps null: false
    end
  end
end
