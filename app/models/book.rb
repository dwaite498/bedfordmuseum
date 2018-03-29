class Book < ActiveRecord::Base
  has_and_belongs_to_many :categories, :through => :books_category
end
