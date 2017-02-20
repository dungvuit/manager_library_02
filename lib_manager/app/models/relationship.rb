class Relationship < ApplicationRecord
  belongs_to :ownerable, polymorphic: true
  belongs_to :targetable, polymorphic: true

  scope :author_name, -> {where targetable_type: Author.name}
end
