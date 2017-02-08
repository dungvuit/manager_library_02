class User < ApplicationRecord
  has_many :comments
  has_many :ratings
  has_many :borrow_books

  has_many :relationships, as: :ownerable
  has_many :books, through: :relationships, source_type: Book.name, source: :targetable
  has_many :following_author, through: :relationships, source_type: Author.name, source: :targetable

  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "ownerable_id", dependent: :destroy
  has_many :following, through: :active_relationships,
    source_type: User.name, source: :targetable

  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "targetable_id", dependent: :destroy
  has_many :followers, through: :passive_relationships,
    source_type: User.name, source: :ownerable
end
