class EventParam < ApplicationRecord
    has_and_belongs_to_many :events

    has_paper_trail
end
