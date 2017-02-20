class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :book

  after_save :update_book_rating

  def update_book_rating
    book.update_rate_numebr
  end
end
