# Login Session Helper
# Finish log in & log out
# Author: Meagan Moore & Steven Royster

module LoginSessionHelper

  # Logs in the given teacher.
  def log_in(teacher)
    session[:teacher_id] = teacher.id
  end
  
  # Remembers a teacher in a persistent session.
  def remember(teacher)
    teacher.remember
    cookies.permanent.signed[:teacher_id] = teacher.id
    cookies.permanent[:remember_token] = teacher.remember_token
  end
  
  # Returns the current logged-in teacher (if any).
  def current_teacher
    if (teacher_id = session[:teacher_id])
      @current_teacher ||= Teacher.find_by(id: teacher_id)
      #current_teacher.last_login = Time.now
    elsif (teacher_id = cookies.signed[:teacher_id])
      teacher = Teacher.find_by(id: teacher_id)
      if teacher && teacher.authenticated?(cookies[:remember_token])
        log_in teacher
        @current_teacher = teacher
      end
    end
  end
  
  # Returns true if the teacher is logged in, false otherwise.
  def logged_in?
    !current_teacher.nil?
  end
  
  # Returns true if the teacher is logged in, false otherwise.
  def logged_out?
    current_teacher.nil?
  end
  
  # Redirects the teacher to the login page if they are not logged in.
  def logged_in
    if !logged_in?
      flash[:danger] = "You are not logged in"
      redirect_to login_url
    end
  end
  
  # Commented out by Steven Royster
  #    We are not implementing a remember me feature
  # Forgets a persistent session.
  # def forget(teacher)
  #   teacher.forget
  #   cookies.delete(:teacher_id)
  #   cookies.delete(:remember_token)
  # end
  
  # Logs out the current teacher.
  def log_out
    #forget(current_teacher)
    session.delete(:teacher_id)
    @current_teacher = nil
  end
  
  # Redirects if user is not admin & is trying to do
  # something they don't have permission to 
  # def admin
  #   if !is_admin?
  #     flash[:danger] = "Unauthorized. You are not an administrator."
  #     redirect_to home1_path
  #   end
  # end
  
    # Redirects if user is not admin & is trying to do
  # something they don't have permission to 
  def super
    if !is_super?
      flash[:danger] = "Unauthorized. You are not a super user."
      redirect_to home1_path
    end
  end
  
end