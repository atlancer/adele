module ApplicationHelper
  def menu_item(name, page_id)
    content_tag(:li, class: active_for(page_id)) do
      link_to name, page_path(page_id)
    end
  end

  def active_for(page_id)
    'active' if current_page? page_path(page_id)
  end
end
