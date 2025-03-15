class Topic < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :name, presence: true

  scope :ordered, -> { order(created_at: :desc) }
end
