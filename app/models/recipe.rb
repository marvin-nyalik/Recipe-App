class Recipe < ApplicationRecord
  has_many :recipe_foods, dependent: :destroy
  validates :name, presence: true
end
