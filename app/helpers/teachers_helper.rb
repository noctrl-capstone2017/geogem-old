module TeachersHelper
  #Author Steven Royster
  
  # Checks to see if the current teacher has admin status
  # Returns true if the teacher is an admin
  def admin?
    current_teacher && current_teacher.power == Admin
  end
  
end
