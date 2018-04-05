class Category < ActiveRecord::Base
  has_and_belongs_to_many :books, through: :books_category
end
