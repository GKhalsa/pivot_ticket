module CategoryHelper
  def display_all_category_link(active_category)
    active = "active" if active_category == "all"
    link_to "All", events_path, class: "collection-item #{active}"
  end

  def display_category_link(category, active_category)
    if category.name == active_category
      link_to category.name,
              category_path(category.name),
              class: "collection-item active"
    else
      link_to category.name,
              category_path(category.name),
              class: "collection-item"
    end
  end
end
