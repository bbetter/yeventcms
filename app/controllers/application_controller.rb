class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_paper_trail_whodunnit

end
