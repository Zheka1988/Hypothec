class Mortgage < ApplicationRecord
  has_one :condition, dependent: :destroy
  
  validates :title, :description, presence: true
end
