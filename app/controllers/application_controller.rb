class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :null_session
  include LoginSessionHelper
  
  private

    # Confirms a logged-in user.
    def logged_in_teacher
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
end