class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :authorize_admin, only: [:create, :new]
  skip_before_action :require_no_authentication

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

 
  def sign_up(resource_name, resource)
    puts resource_name, resource
  end
  
  def authorize_admin
    return if current_user.admin?
    redirect_to root_path, alert: "Admin only!"
  end
  
end
