class Event < ApplicationRecord
  include ActiveModel::Serializers::JSON
  
  belongs_to :category
  has_and_belongs_to_many :event_params
  has_many_attached :attachments
  has_many :comments, as: :commentable, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true

  has_paper_trail

  def to_s
    name
  end
end
