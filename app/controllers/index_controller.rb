class IndexController < ApplicationController
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
end
