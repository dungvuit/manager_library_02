class Relationship < ApplicationRecord
  belongs_to :ownerable, polymorphic: true
  belongs_to :targetable, polymorphic: true
end
