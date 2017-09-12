class BookstoreController < ApplicationController
    
    def index
        @books = Book.all
    end
    
    def show
        @book = Book.find(params[:id])
        @booksample = Book.all.sample(4)
    end
end
