class IndexController < ApplicationController
  before_action :authenticate_user!, except: [:index, :directions, :membership, :research, :schedule, :about]
  before_action :user_is_admin, except: [:index, :directions, :membership, :research, :schedule, :about]
  

  
  def index
    @indexitems = Indexitem.all
    @articles = Article.where(main_page: true).order('main_page_index')
  end
  
  def directions 
  end
  
  def membership
  end
  
  def research
  end
  
  def schedule
    @forums = Forum.all
  end
  
  def manager
    @users = User.all.where.not(admin: true)
  end
  
  def renew(user)
    update_user
    user.save
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
    @indexitem = Indexitem.new
  end
  
  def update
  end
  
  def edit
  end
  
  private

  def index_params
    params.require(:indexitem).permit(:title, :body, :link)
  end
  
  def user_is_admin
       unless current_user && current_user.admin?
           redirect_to root_path
           flash[:alert] = "User not authorized"
       end
  end
  
  def update_user(user)
    if Date.current.today? || Date.current.future?
      user.update(expires_at: expires_at + 1.year)
      # user.expires_at = user.expires_at + 1.year
    else
      user.update(DateTime.now + 1.year)
    end
  end
end
