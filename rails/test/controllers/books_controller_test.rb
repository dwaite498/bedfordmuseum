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

    post books_url(
      book: {
        title: 'title',
        description: 'description',
        author: 'author',
        price: '1.2',
        shipping: '3.4',
        paypal_link: 'paypal_link'})

    assert_redirected_to books_url
    assert_equal Book.last.title, 'title'
    assert_equal Book.all.count, initial_count + 1
  end
end
