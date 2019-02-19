require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  teardown do
    Rails.cache.clear
  end
    
  test 'Should get index' do
    get books_url

    assert_equal 'index', @controller.action_name
    assert_response :success
    assert_select '.col-md-3', Book.all.count
  end

  test 'Should create' do
    initial_count = Book.all.count

    new_book

    assert_redirected_to books_url
    assert_equal Book.last.title, 'title'
    assert_equal Book.all.count, initial_count + 1
  end
  
  test 'should update' do
    book = Book.new(price: 1)
    book.save

    patch book_url(book), params: { book: { price: book.price + 1 } }
    
    assert_equal 2, Book.find(book.id).price
  end
end
