# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
category = ["local", "WWII", "geneology"]
40.times do
    book = Book.create!(
       :title => Faker::Book.title,
       :description => Faker::Simpsons.quote,
       :author => Faker::Book.author,
       :category => category.sample,
       :image_file_name => "classof1940.jpg",
       :price => Faker::Number.decimal(2),
       :shipping => Faker::Number.decimal(2),
       :paypal_link => "www.paypal.com"
       )
    book.save
end
