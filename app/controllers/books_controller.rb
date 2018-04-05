class BooksController < ApplicationController
   before_action :find_book, only: [:show, :edit, :update, :destroy]
   before_action :user_is_admin, only: [:edit, :update, :destroy, :create, :new]

    def index
        if params[:category].blank?
            @books = Book.all.shuffle
        else
            @category_id = Category.find_by(name: params[:category]).id
            @books = Book.where(category_id: @category_id).order('title DESC')
        end
    end

    def show
        @booksample = Book.where('id != ?', @book.id).where('category_id = ?', @book.category_id).sample(4)
    end

    def new
        @book = Book.new
        @categories = Category.all.map{ |c| [c.name, c.id]}
    end

    def create
        @book = Book.new(book_params)
        if @book.save
            redirect_to books_path
            @book.category_id = params[:category_id]
        else
           render 'new'
        end
    end

    def destroy
        @book.destroy
        if @book.destroy
            redirect_to books_path
           else
            redirect_to @book
        end
    end

    def edit
        @categories = Category.all.map{ |c| [c.name, c.id]}

    end

    def update
        if @book.update(book_params)
           redirect_to @book
        else
            render 'edit'
        end
    end

    private

    def book_params
       params.require(:book).permit(:title, :description, :author, :category, :image_file_name, :category_id, :price, :shipping, :paypal_link)
    end

    def find_book
        @book = Book.find(params[:id])
    end

    def user_is_admin
       unless current_user && current_user.admin?
           redirect_to books_path
           flash[:alert] = 'User not authorized'
       end
    end
end
