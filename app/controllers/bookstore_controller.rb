class BookstoreController < ApplicationController
   
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
    end
    
    def create
    end
    
    def destroy
    end
    
    def edit
    end
    
    def update
    end
end
