module NavHelper
  def nav_link(id, label, path)
    selected_item = content_for(:selected_nav_item)

    li_class = nil
    if selected_item.present? && selected_item.to_sym == id
      li_class = 'active'
    end

    content_tag :li, class: li_class do
      link_to label, path
    end
  end
end
