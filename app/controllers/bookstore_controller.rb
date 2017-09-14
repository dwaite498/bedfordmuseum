class BookstoreController < ApplicationController
   before_action :find_book, only: [:show, :edit, :update, :destroy]
   
    def index
        if params[:category].blank?
            @books = Book.all.order("created_at DESC")
        else
            @category_id = Category.find_by(name: params[:category]).id
            @books = Book.where(:category_id => @category_id).order("title DESC")
        end
    end
    
    def show
        @book = Book.find(params[:id])
        @booksample = Book.all.sample(4)
    end
    
    def new
        @book = Book.new
        @categories = Category.all.map{ |c| [c.name, c.id]}
    end
    
    def create
        @book = Book.new(book_params)
        if @book.save
            redirect_to bookstore_index_path
            @book.category_id = params[:category_id]
        else
           render 'new' 
        end
    end
    
    def destroy
    end
    
    def edit
    end
    
    def update
    end
    
    private
    
    def book_params
       params.require(:book).permit(:title, :description, :author, :category, :image_file_name, :category_id, :price, :shipping)
    end
    
    def find_book
        @book = Book.find(params[:id])
    end
end
