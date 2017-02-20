class BorrowBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum status: [:pending, :borrowing, :return, :reject]

  validates :user, presence: true
  validates :book, presence: true
  validates :date_borrow, presence: true

  validate :check_date_return

  scope :overdue, -> {where "date_return < ?", Date.today}

  private
  def check_date_return
    if self.date_return.present?
      if self.date_return < Date.today
        errors.add :date_return, I18n.t("models.borrow_books.add_errors_return")
      end
    else
      errors.add :date_return, I18n.t("models.borrow_books.add_errors_return_nil")
    end
  end

  class << self
    def to_csv options = {}
      CSV.generate options do |csv|
        csv << column_names
        all.each do |borrow|
          csv << borrow.attributes.values_at(*column_names)
        end
      end
    end
  end
end
