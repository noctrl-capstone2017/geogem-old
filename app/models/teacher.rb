class Teacher < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_SCREEN_NAME_REGEX = /\A[A-Za-z\d]+\z/
  
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
end

