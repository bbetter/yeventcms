class Category < ApplicationRecord
  has_many :events, dependent: :destroy
  validates :name, presence: true

  has_paper_trail
end
