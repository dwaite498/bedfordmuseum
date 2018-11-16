class BooksController < ApplicationController
    def index
        @books = Book.all
    end

    def create
        @book = Book.new(book_params)
        if @book.save
            redirect_to books_path
        else
            render 'new'
        end
    end

    private

    def book_params
        params.require(:book).permit(:title, :description, :author, :price, :shipping, :paypal_link)
    end
end
