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
end
