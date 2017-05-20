# Application Controller
# Confirms that the teacher is logged in
# Author: Meagan Moore & Steven Royster

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include LoginSessionHelper
  before_filter :require_login

  private
    # Confirms a logged-in user.
    def logged_in_teacher
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
  private
    # Guard each page, checks for logged in
    def require_login
      unless current_teacher
      flash[:danger] = "Log in is not current"
        redirect_to login_url
      end
    end
    
end