# author: Kevin M, Tommy B
# Teacher model validation.
class Teacher < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
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
  
  #Creates the relationship of what students belong to the teacher
  #author Matthew OBzera + Alexander Pavia
  has_many :active_relationships, class_name:  "RosterStudent",
                                  foreign_key: "teacher_id",
                                  dependent:   :destroy

  has_many :students, through: :active_relationships, source: :student
  
  ### METHODS ###
  # Returns a random token.
  def Teacher.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = Teacher.new_token
    update_attribute(:remember_digest, Teacher.digest(remember_token))
  end
  
  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Returns the hash digest of the given string.
  def Teacher.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end
<<<<<<< HEAD
end
=======
end

>>>>>>> d09b1f7f25d68368b39db55827bdc36aef5bb9be
