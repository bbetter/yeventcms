class EventParam < ApplicationRecord
    has_and_belongs_to_many :events
    
    validates :name, presence: true, uniqueness: { case_sensitive: true }

    has_paper_trail
end
