class Category < ApplicationRecord
  has_many :relationships, as: :ownerable
  has_many :books, through: :relationships,
    source_type: Book.name, source: :targetable

  scope :sort_by_create_at, -> {order created_at: :desc}
  scope :search_by_name, -> search {where "name LIKE ?", "%#{search}%"}

  class << self
    def to_csv options = {}
      CSV.generate options do |csv|
        csv << column_names
        all.each do |category|
          csv << category.attributes.values_at(*column_names)
        end
      end
    end
  end
end
