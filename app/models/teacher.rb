class Teacher < ApplicationRecord
  validates :teacher_password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :teacher_password_confirmation, presence: true, length: { minimum: 6 }, allow_nil: true
end
