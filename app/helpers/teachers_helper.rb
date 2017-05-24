# Kevin M:
# Contains methods for checking permissions.
# This is basically all just Steven Royster's work. Beautiful! 
module TeachersHelper
    # Author: Steven Royster
    # If the teacher is not an admin then they 
    #  will be flashed an unauthorized prompt and redirected to home
    def is_admin?
      current_teacher && current_teacher.powers == "Admin"
    end
    
    # Author: Steven Royster
    # Checks to see if the current teacher has admin status
    # Returns true if the teacher is an admin
    def is_admin
      if !is_admin?
        flash[:danger] = "Unauthorized"
        redirect_to login_path
      end
    end
    
    # Author: Steven Royster
    # If the teacher is not a super user then they 
    #  will be flashed an unauthorized prompt and redirected to home
    def is_super?
      current_teacher && current_teacher.id == 1
    end
    
     # Author: Steven Royster
    # Checks to see if the current teacher has super user status
    # Returns true if the teacher is a super user
    def is_super
      if !is_super?
        flash[:danger] = "Unauthorized"
        redirect_to home_path
      end
    end
end

