class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :pagination, -> params{paginate page: params, per_page: Settings.per_page}
end
