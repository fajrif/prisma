class Admins::BaseController < ActionController::Base
  layout "admin"

	include Locale

  protect_from_forgery

  # Devise filter authenticate admin
  before_action :authenticate_admin!

  # include all helpers, all the time
  helper :all

end
