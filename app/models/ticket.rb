class Ticket < ApplicationRecord
  has_one :tag

  validates :user_id, presence: true
  validates :title, presence: true
end
