class SessionNote < ApplicationRecord
    belongs_to :session
    delegate :teacher, :student, to: :session
    default_scope -> { order(created_at: :desc) }
    validates :session_id, presence: true
    validates :note, presence: true
    

end
