require 'set'
class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]
  before_action :user_is_admin, only: [:edit, :update, :destroy, :create, :new]

  def index
    if params[:category].blank?
      @books = Book.all.shuffle
    else
      category = Category.find_by(name: params[:category])
      @books = category.books.order('title DESC')
    end
  end

  def show
    @booksample = Set.new
    @book.categories.each do |c|
      @booksample.merge(c.books)
    end
    @booksample = @booksample.to_a.sample(4)
  end

  def new
    @book = Book.new
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def create
    @book = Book.new(book_params)
    assign_categories(@book, params[:book][:category_ids])
    if @book.save
      redirect_to books_path
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
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def update
    # TODO: figure out how to do this here too; do you need to save after? what about update?
    #assign_categories(@book, params[:book][:category_ids])

    if @book.update(book_params)
      redirect_to @book
    else
      render 'edit'
    end
  end

  private
  
  def assign_categories(book, category_ids)
    category_ids.each do |c|
      next if c.empty?
      book.categories << Category.find(c)
    end
  end

  def book_params
    params.require(:book).permit(:title, :description, :author, :image_file_name, :price, :shipping, :paypal_link)
  end

  def find_book
    @book = Book.find(params[:id])
  end

  def user_is_admin
    return if current_user && current_user.admin?
    redirect_to books_path
    flash[:alert] = 'User not authorized'
  end
end
