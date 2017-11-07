class IndexController < ApplicationController
  before_action :authenticate_user!, only: [:manage]
  
  def index
    @indexitems = Indexitem.all
  end
  
  def directions 
  end
  
  def membership
  end
  
  def research
  end
  
  def schedule
  end
  
  def manage
    @indexitems = Indexitem.all
  end
  
  def create
    @indexitem = Indexitem.create(index_params)
    if index.save
      redirect_to manage_path
    else
      render 'new'
    end
  end
  
  def new
  end
  
  def update
  end
  
  def edit
  end

  def index_params
    params.require(:indexitem).permit(:title, :body, :image)
  end
end
