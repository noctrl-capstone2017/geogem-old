# author: Kevin M, Tommy B
# Teacher model validation.
class Teacher < ApplicationRecord
<<<<<<< HEAD

  
  #Creates the relationship of what students belong to the teacher
  #author Matthew OBzera & Alex P
  has_many :active_relationships, class_name:  "RosterStudent",
                                  foreign_key: "teacher_id",
                                  dependent:   :destroy

  has_many :students, through: :active_relationships, source: :student 


=======
  
>>>>>>> 2b80b7e5c413d5d53fe8ebbc65463b4f9c8920bb
  before_save   :downcase_email
  ###REGEX###
  #Only allows legit email formatting
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  #Prohibits any whitespace character (spaces, tabs, ¶, etc)
  VALID_USER_NAME_REGEX = /\A[\S]+\z/
  
  #Alphanumerical stuff only.
  VALID_SCREEN_NAME_REGEX = /\A[A-Za-z\d]+\z/
  
  ###VALIDAITONS###
  validates :user_name,  presence: true, length: { maximum: 75 }
    #Commented out until login stuff is put in place. -KM
  #validates :password_digest, presence: true, length: {minimum: 6 }
  
  validates :full_name, presence: true, length: { maximum: 75 }
  validates :screen_name, presence: true, length: { maximum: 8 },
                    format: { with: VALID_SCREEN_NAME_REGEX },
                    uniqueness: { case_sensitive: false}
  validates :icon,  presence: true
  validates :color, presence: true
  
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :powers, presence: true
  validates :school_id, presence: true
  
  
  validates :password_digest, presence: true, length: {minimum: 6 }
  has_secure_password
  
  validates :teacher_password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :teacher_password_confirmation, presence: true, length: { minimum: 6 }, allow_nil: true
  
  private

<<<<<<< HEAD

=======
    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end
    
>>>>>>> 2b80b7e5c413d5d53fe8ebbc65463b4f9c8920bb
end

