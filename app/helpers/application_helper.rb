module ApplicationHelper
  def menu_item(name, page_id, base_id = nil)
    content_tag(:li, class: active_for(page_id, base_id)) do
      link_to name, page_path(page_id.sub(/\A\//, ''))
    end
  end

  def sidebar_item(name, page_id)
    klass = 'list-group-item '
    klass << active_for(page_id).to_s

    content_tag(:li, class: klass) do
      link_to name, page_path(page_id.sub(/\A\//, ''))
    end
  end

  def active_for(page_id, base_id = nil)
    id = base_id || page_id
    'active' if request.fullpath =~ Regexp.new(Regexp.quote(id))
  end

  def portfolio(folder = :bouquets)
    path = Rails.root.join('app', 'assets', 'images', 'portfolio', folder.to_s, '*_thumb.*')
    Dir[path].map{|filepath| filepath.sub(/^.*images\//, '') }.sort.each_slice(3).to_a
  end

  def need_footer?
    request.fullpath !~ Regexp.new(Regexp.quote('zayavka_poluchena'))
  end
end
