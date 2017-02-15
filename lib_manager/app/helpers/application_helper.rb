module ApplicationHelper
  def full_title page_title = ""
    base_title = t "helpers.base_title"
    base_title = "#{page_title} | #{base_title}" if page_title.present?
  end

  def image_for object, options = {size: Settings.size_image}
    size = options[:size]
    image_tag (object.image_url || "available.jpg"), size: size
  end
end
