module ApplicationHelper
  def page_title
    title_parts = ["GDS Missions"]

    if content_for?(:title)
      title_parts << content_for(:title)
    elsif content_for(:head_title)
      title_parts << content_for(:head_title)
    end

    title_parts.reverse.join(" - ")
  end
end
