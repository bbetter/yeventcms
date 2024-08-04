class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_paper_trail_whodunnit

  private

  def authenticate_admin!
    redirect_to root_path, alert: "Not authorized!" unless current_user.admin?
  end
end
