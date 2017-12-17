module ApplicationHelper
    def current_user_is_admin?
       signed_in? && current_user.admin?
    end
end
