class DatabaseController < ApplicationController
    before_action :authenticate_user!
    before_action :user_is_admin
    
    
    def index
        
    end
    
    private
    
    def user_is_admin
       unless current_user && current_user.admin?
           redirect_to root_path
           flash[:alert] = "User not authorized"
       end
  end
end
