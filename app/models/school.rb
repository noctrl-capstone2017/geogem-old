# written by Robert Herrera
# Makes sure all fields are filled out when creating a new school. Limits on fields' length.
# model validation authors: Kevin M, Tommy B
 
class School < ApplicationRecord

  #Only allows legit email formatting
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  #Prohibits any whitespace character (spaces, tabs, ¶, etc)
  VALID_USER_NAME_REGEX = /\A[\S]+\z/
  
  #Alphanumerical stuff only.
  VALID_SCREEN_NAME_REGEX = /\A[A-Za-z\d]+\z/

  validates :screen_name,  presence: true, length: { maximum: 8 }
                    #format: { with: VALID_SCREEN_NAME_REGEX },
                   # uniqueness: { case_sensitive: false}
                    
  validates :full_name,  presence: true, length: { maximum: 75 }
  validates :website, presence: true, length: { maximum: 75 }
  validates :email, presence: true, length: { maximum: 255 }
                  #  format: { with: VALID_EMAIL_REGEX },
                  #  uniqueness: { case_sensitive: false }
                    
  validates :description, presence: true, length: { maximum: 255 }
  validates :color, presence: true
  
    
  #has_many :active_relationships, class_name:  "Teacher",
   #                                foreign_key: "student_id",
   #                                dependent:   :destroy
 # has_many :teachers, through: :active_relationships, source: :teachers
    
  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end
    
end

