class Publisher < ApplicationRecord
  has_many :books
  has_many :authors
end
