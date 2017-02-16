class Author < ApplicationRecord
  
  scope :sort_by_create_at, -> {order created_at: :desc}

  mount_uploader :image, AvatarUploader

  belongs_to :publisher

  enum gender: {male: 0, female: 1}

  has_many :relationships, as: :ownerable
  has_many :books, through: :relationships,
    source_type: Book.name, source: :targetable
  has_many :follower_users, through: :relationships,
    source_type: User.name, source: :ownerable
end
