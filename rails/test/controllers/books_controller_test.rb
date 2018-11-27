require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
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
    teardown do
      Rails.cache.clear
    end
  end
  
  test 'should edit' do
    initial_value = Book.first.price
    
    assert_equal Book.first.price, Book.first.price + 1
  end
end

