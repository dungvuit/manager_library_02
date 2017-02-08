module ApplicationHelper
  def full_title page_title = ""
    base_title = t "helpers.base_title"
    base_title = "#{page_title} | #{base_title}" if page_title.present?
  end
end
