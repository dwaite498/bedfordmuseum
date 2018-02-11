class UsersController < ApplicationController
  def renew
    user = User.find(params[:user_id])
    if user.expires_at.future?
      user.expire_at!(user.expires_at + 1.year)
    else
      user.expire_at!(DateTime.now + 1.year)
    end
    redirect_to users_path
  end

  def index
    @users = User.all.where.not(admin: true)
  end
  
  def edit
    @user = User.find(params[:user_id])
  end
  
  def update
    user = User.find(params[:user_id])
    if user.update(user_params)
       redirect_to users_path
    else
        render 'edit'
    end
  end

  def show
  end

  def deactivate
    user = User.find(params[:user_id])
    user.expire_now!
    redirect_to users_path
  end
end

private

def user_params
  params.require(:user).permit(:name, :email)
end

  # def update_user(user)
  #   if Date.current.today? || Date.current.future?
  #     user.update(expires_at: expires_at + 1.year)
  #     # user.expires_at = user.expires_at + 1.year
  #   else
  #     user.update(DateTime.now + 1.year)
  #   end
  # end