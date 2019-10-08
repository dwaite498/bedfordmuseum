class BooksController < ApplicationController
    before_action :authenticate_admin!, except: [:show, :index]
    
    def index
        @books = Book.all
    end
    
    def show
        @book = Book.find(params[:id])
        @books = Book.all.sample(3)
    end
    
    def new
       @book = Book.new
    end

    def create
        @book = Book.new(book_params)
        if @book.save
            redirect_to books_path
        else
            render 'new'
        end
    end
    
    def destroy
        @book = Book.find(params[:id])
       @book.destroy
       if @book.destroy
           redirect_to books_path
       else
           redirect_to @book
       end
    end
    
    def edit
        @book = Book.find(params[:id])
    end
    
    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            redirect_to @book
        else
            render edit
        end
    end

    private
    def book_params
        params.require(:book).permit(:title, :description, :author, :price, :shipping, :paypal_link, :image)
    end
end
