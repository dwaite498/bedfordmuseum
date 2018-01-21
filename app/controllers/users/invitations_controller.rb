class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [:name])
  end
  
  private
  
  def accept_resource
    user = super
    user.expire_at! (DateTime.now + 1.minute)
    user
  end
end