#author Matthew O & Alex P
class Session < ApplicationRecord
  has_many :session_events , dependent: :destroy
end
