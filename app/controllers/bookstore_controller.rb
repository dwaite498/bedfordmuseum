class BookstoreController < ApplicationController
    
    def index
        @books = Book.all
    end
end
