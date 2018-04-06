class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [:name])
  end

  private

  def accept_resource
    user = super
    user.expires_at! (Time.now + 1.year)
    user
  end
end
