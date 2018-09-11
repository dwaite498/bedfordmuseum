class ArticlesController < ApplicationController
  before_action :user_is_admin, except: [:index]

  def index
    @articles = Article.all.order('created_at DESC')
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to articles_path
    else
      render 'new'
      flash[:alert] = 'Error creating Article, please try again.'
    end
  end

  def edit
    find_article
  end

  def update
    find_article
    if @article.update(article_params)
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
    find_article
    unless @article.destroy
      flash[:alert] = 'Error deleting article. Please try again.'
    end
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :main_page, :main_page_index, :expiration_date)
  end

  def find_article
    @article = Article.find(params[:id])
  end

  def user_is_admin
    return if current_user && current_user.admin?
    redirect_to schedule_path
    flash[:alert] = 'User not authorized'
  end
end