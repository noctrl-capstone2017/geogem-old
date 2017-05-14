# Login Session Controller
# Finish log in & log out
# Author: Meagan Moore & Steven Royster

class LoginSessionController < ApplicationController

  # The teacher can only log out if they are actually logged in
  before_action :logged_in, only: [:destroy]
  
  # login page
  def new
  end
  
  # logs in the teacher if successful, flashes a danger if invalid log in info
  def create
    teacher = Teacher.find_by(:user_name => params[:login_session][:user_name].downcase)
    if teacher && teacher.authenticate(params[:login_session][:password])
      log_in teacher
      params[:login_session][:remember_me] == '1' ? remember(teacher) : forget(teacher)
      redirect_to home1_path
      
    else
      flash.now[:danger] = 'Invalid username/password combination'
      render 'new'
    end
    
  end

  # logout page
  def logout
      log_out if logged_in?
  end
  
end
