module AdminAuthentication
    extend ActiveSupport::Concern
  
    included do
      before_action :authenticate_admin!
    end
  
    private
  
    def authenticate_admin!
      redirect_to root_path, alert: "Not authorized!" unless current_user.admin?
    end
  end