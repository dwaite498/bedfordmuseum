# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# paypal_link = ['<form target="paypal" action="https://www.paypal.com/cgi-bin/webscr" method="post">
#   <input type="hidden" name="business" value="kin@kinskards.com">
#   <input type="hidden" name="cmd" value="_cart">
#   <input type="hidden" name="add" value="1">
#   <input type="hidden" name="item_name" value="Birthday - Cake and Candle">
#   <input type="hidden" name="amount" value="3.95">
#   <input type="hidden" name="currency_code" value="USD">
#   <input type="image" name="submit"
#     src="https://www.paypalobjects.com/webstatic/en_US/i/btn/png/btn_addtocart_120x26.png"
#     alt="Add to Cart">
#   <img alt="" width="1" height="1"
#     src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif">
# </form>']
@bookcategory = ['Local History', 'Warfare', 'Genealogy', 'Trains', 'Dvds and Cds', 'Gifts and Accessories']

@bookcategory.each do |category|
  Category.create(
    name: category
  )
end

require_relative 'booklist.rb'

User.create(
  email: 'dwaite498@gmail.com',
  password: 'password',
  admin: true,
  created_at: '2017-10-14 20:26:01',
  name: 'Museum Admin'
)

User.create(
  email: 'email@email.com',
  name: 'Test1',
  password: 'password',
  admin: false,
  created_at: '2017-10-14 20:26:01',
  expires_at: '2018-10-15 00:00:00'
)

User.create(
  email: 'email1@email.com',
  name: 'Test2',
  password: 'password',
  admin: false,
  created_at: '2017-10-14 20:26:01',
  expires_at: '2018-10-15 00:00:00'
)

User.create(
  email: 'email@email.com',
  name: 'Test3',
  password: 'password',
  admin: false,
  created_at: '2017-10-14 20:26:01',
  expires_at: '2018-10-15 00:00:00'
)
