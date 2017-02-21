class Author < ApplicationRecord
  scope :sort_by_create_at, -> {order created_at: :desc}
  scope :search_by_name, -> search{where "name LIKE ?", "%#{search}%"}

  mount_uploader :image, AvatarUploader

  belongs_to :publisher

  enum gender: {male: 0, female: 1}

  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "ownerable_id", dependent: :destroy
  has_many :books, through: :active_relationships, source_type: Book.name,
    source: :targetable

  has_many :passive_relationships, -> {author_name}, class_name: Relationship.name,
    foreign_key: "targetable_id", dependent: :destroy
  has_many :follower_users, through: :passive_relationships,
    source_type: User.name, source: :ownerable

  class << self
    def to_csv options = {}
      CSV.generate options do |csv|
        csv << column_names
        all.each do |author|
          csv << author.attributes.values_at(*column_names)
        end
      end
    end
  end
end
