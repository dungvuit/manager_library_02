class Book < ApplicationRecord
  mount_uploader :image, AvatarUploader

  scope :sort_by_create_at, -> {order created_at: :desc}

  has_many :borrow_books
  has_many :comments
  has_many :ratings

  has_many :relationships, as: :targetable
  has_many :users, through: :relationships, source_type: User.name,
    source: :ownerable
  has_many :categories, through: :relationships, source_type: Category.name,
    source: :ownerable
  has_many :authors, through: :relationships, source_type: Author.name,
    source: :ownerable

  belongs_to :publisher

  scope :search_book, -> book_name, author_name, category_name, publisher_name do
    where("books.name LIKE ?","%#{book_name}%")
    .joins(:authors).where("authors.name LIKE ?", "%#{author_name}%")
    .joins(:categories).where("categories.name LIKE ?", "%#{category_name}%")
    .joins(:publisher).where "publishers.name LIKE ?","%#{publisher_name}%"
  end

  def update_rate_numebr
    rate = ratings.pluck(:rate).compact
    avg = rate.count == Settings.zero ? Settings.zero : rate.sum/rate.count
    update_attributes rating: avg
  end

  class << self
    def to_csv options = {}
      CSV.generate options do |csv|
        csv << column_names
        all.each do |book|
          csv << book.attributes.values_at(*column_names)
        end
      end
    end
  end
end
