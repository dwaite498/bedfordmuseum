class ArticlesController < ApplicationController
    before_action :user_is_admin, except: [:index]
    
    def index
        @articles = Article.all.order("created_at DESC")
    end
    
    def new
        user_is_admin
        @article = Article.new
    end
    
    def  create
        @article = Article.new(article_params)
        
        if @article.save
            redirect_to articles_path
        else
           render 'new'
           flash[:alert] = "Error creating Article, please try again."
        end
    end
    
    def edit
        find_article
    end
    
    def update
        find_article
        @article.update(article_params)
        if @article.update(article_params)
           redirect_to articles_path 
        else
            render 'edit' 
        end
    end
    
    def destroy
        find_article
        @article.destroy
        if @article.destroy
           redirect_to articles_path 
        else
            redirect_to articles_path
            flash[:alert] = "Error deleting article. Please try again."
        end
    end
    
private
    
    def article_params
       params.require(:article).permit(:title, :body, :main_page, :main_page_index, :expiration_date) 
    end
    
    def find_article
       @article = Article.find(params[:id]) 
    end
    
    def user_is_admin
        unless current_user && current_user.admin?
           redirect_to articles_path
           flash[:alert] = "User not authorized"
        end
    end

end
