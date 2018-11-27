ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

    def new_book
      post books_url(
        book: {
          title: 'title',
          description: 'description',
          author: 'author',
          price: '1.2',
          shipping: '3.4',
          paypal_link: 'paypal_link'})
    end
end
