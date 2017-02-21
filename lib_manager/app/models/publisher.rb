class Publisher < ApplicationRecord
  has_many :books
  has_many :authors

  scope :sort_by_create_at, -> {order created_at: :desc}
  scope :search_by_name, -> search {where "name LIKE ?", "%#{search}%"}

  class << self
    def to_csv options = {}
      CSV.generate options do |csv|
        csv << column_names
        all.each do |publisher|
          csv << publisher.attributes.values_at(*column_names)
        end
      end
    end
  end
end
