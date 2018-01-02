class ForumController < ApplicationController
     before_action :user_is_admin
    
    def new 
        @forum = Forum.new
    end
    
    def create
        @forum = Forum.new(forum_params)
        
        if @forum.save
           redirect_to schedule_path 
        else
            render 'new'
            flash[:alert] = "Error creating forum schedule item. Please try again."
        end
    end
    
    def edit 
        @forum = Forums.find(params[:id])
    end
    
    def update
        @forum = Forums.find(params[:id])
        @forum.upsate(forum_params)
        if @forum.update
           redirect_to schedule_path 
        else
            render 'edit'
            flash[:alert] = "Error editing forum schedule item. Please try again."
        end
    end
    
    def destroy
        @forum = Forums.find(params[:id])
        @forum.destroy
        if @forum.destroy
           redirect_to schedule_path 
        else
            redirect_to schedule_path
            flash[:alert] = "Error deleting forum schedule item. Please try again."
        end
    end


    private
    
    def forum_params
        params.require(:forum).permit(:date, :text) 
    end
    
    def user_is_admin
        unless current_user && current_user.admin?
           redirect_to articles_path
           flash[:alert] = "User not authorized"
        end
    end

end