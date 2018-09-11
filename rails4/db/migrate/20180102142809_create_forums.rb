class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.date :date
      t.text :text

      t.timestamps null: false
    end
  end
end
