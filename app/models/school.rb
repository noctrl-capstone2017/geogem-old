#written by Robert Herrera
# Makes sure all fields are filled out when creating a new school. Limits on fields' length.
class School < ApplicationRecord
  validates :screen_name,  presence: true, length: { maximum: 8 }
  validates :full_name,  presence: true, length: { maximum: 75 }
  validates :icon,  presence: true, length: { maximum: 75 }
  validates :website, presence: true, length: { maximum: 75 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :color, presence: true

end

