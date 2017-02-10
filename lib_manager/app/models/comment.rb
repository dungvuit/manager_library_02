class Comment < ApplicationRecord
  scope :sort_by_create_at, -> {order created_at: :desc}

  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
end
