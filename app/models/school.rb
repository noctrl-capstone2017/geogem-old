#written by Robert Herrera
# Makes sure all fields are filled out when creating a new school. Limits on fields' length.
class School < ApplicationRecord
  validates :school_icon_name,  presence: true, length: { maximum: 75 }
  validates :school_name,  presence: true, length: { maximum: 15 }
  validates :school_website, presence: true, length: { maximum: 75 }
  validates :school_email, presence: true, length: { maximum: 255 }
  validates :school_description, presence: true, length: { maximum: 255 }
  validates :color, presence: true

end

