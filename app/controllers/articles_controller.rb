class ArticlesController < ApplicationController
    
    def index
        @articles = Article.all.order("created_at DESC")
    end
    
    def  create
    end
    
    def new
    end
end
