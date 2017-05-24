# Application Helper
# Fills an array with all student art, gets a random image
# Author: Meagan Moore & Steven Royster
# Strategy credit: GiftGarden Capstone Fall 2016

module ApplicationHelper
  
  # Returns random artwork path
  def random_student_art
    images = [ "student_art/art1_Jimmy.jpg", "student_art/art2_Janey.jpg", 
          "student_art/art3_Steven.jpg", "student_art/art4_Trudy.jpg" ]
    images[rand(images.size)]
  end

end
