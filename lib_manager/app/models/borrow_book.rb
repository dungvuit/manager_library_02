class BorrowBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum status: [:pending, :borrowing, :returned]

  validates :user, presence: true
  validates :book, presence: true
  validates :date_borrow, presence: true
  validates :date_return, presence: true
end
