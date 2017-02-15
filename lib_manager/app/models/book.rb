class Book < ApplicationRecord
  mount_uploader :image, AvatarUploader

  has_many :borrow_books
  has_many :comments
  has_many :ratings

  has_many :relationships, as: :targetable
  has_many :users, through: :relationships, source_type: User.name, source: :ownerable
  has_many :categories, through: :relationships, source_type: Category.name, source: :ownerable
  has_many :authors, through: :relationships, source_type: Author.name, source: :ownerable

  belongs_to :publisher

  scope :search_book, -> book_name, author_name, category_name, publisher_name do
    where("books.name LIKE ?","%#{book_name}%").joins(:authors)
    .where("authors.name LIKE ?", "%#{author_name}%")
    .joins(:categories).where("categories.name LIKE ?", "%#{category_name}%")
    .joins(:publisher).where "publishers.name LIKE ?","%#{publisher_name}%"
  end
end
