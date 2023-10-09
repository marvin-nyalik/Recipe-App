class Inventory < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }

  belongs_to :user, foreign_key: 'user_id'
end
