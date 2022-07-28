class Mortgage < ApplicationRecord
  validates :title, :description, presence: true
end
