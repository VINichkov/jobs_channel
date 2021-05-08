module ApplicationHelper
  def brand_tag(image, title = Property.find_prop(:title))
    content_tag(:div, class: 'mx-auto') do
      div = image_tag(image_path(image), alt: title, size: 32)
      div + content_tag(:span, title)
    end
  end


end
