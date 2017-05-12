class SessionNote < ApplicationRecord
    belongs_to :session
    validates :session_id, presence: true
    validates :note, presence: true
end
