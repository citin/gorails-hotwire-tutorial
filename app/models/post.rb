class Post < ApplicationRecord
  include Likeable

  belongs_to :author, class_name: "User"

  validates :body, presence: true

  scope :ordered, -> { order(created_at: :desc) }

  def is_author?(user)
    author == user
  end
end
