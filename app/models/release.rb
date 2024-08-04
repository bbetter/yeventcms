class Release < ApplicationRecord
  belongs_to :event

  enum environment: { demo: 0, prod: 1 }
  enum platform: { android: 0, ios: 1, web: 2}

  validates :environment, presence: true
  validates :released_at, presence: true
end
