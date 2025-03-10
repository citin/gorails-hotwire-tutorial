class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates :body, presence: true

  scope :ordered, -> { order(created_at: :desc) }
end
