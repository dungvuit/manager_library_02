class User < ApplicationRecord
  attr_accessor :remember_token
  before_save :downcase_email

  mount_uploader :image, AvatarUploader

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

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  has_secure_password

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password? token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def current_user? current_user
    self == current_user
  end

  def follow_book book
    books << book
  end

  def unfollow_book book
    books.destroy book
  end

  def following_book? book
    books.include? book
  end

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest string
      cost = ActiveModel::SecurePassword.min_cost ?
        BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end
  end

  private
  def downcase_email
    email.downcase!
  end
end
