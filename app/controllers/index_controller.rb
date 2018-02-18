class IndexController < ApplicationController
  def index
    @articles = Article.where(main_page: true).order('main_page_index')
  end
  
  def schedule
    @forums = Forum.all
  end
end
