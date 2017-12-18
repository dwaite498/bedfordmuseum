class ArticlesController < ApplicationController
    
    def index
        @articles = Article.all.order("created_at DESC")
    end
    
    def new
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
    
private
    
    def article_params
       params.require(:article).permit(:title, :body, :main_page, :main_page_index, :expiration_date) 
    end

end
