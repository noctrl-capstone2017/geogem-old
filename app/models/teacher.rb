class Teacher < ApplicationRecord
  
  validates :password_digest, presence: true, length: {minimum: 6 }
  
  has_secure_password
  
  validates :teacher_password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :teacher_password_confirmation, presence: true, length: { minimum: 6 }, allow_nil: true
  
end
