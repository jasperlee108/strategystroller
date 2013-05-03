module ApplicationHelper
  
  # Put here so CU controller and Provider controller can both use it
  # Code is taken from:
  # http://railscasts.com/episodes/228-sortable-table-columns
  # modified based on the suggestion of:
  # Aaron James Banda in the comment on that same link
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to "#{title} <i class='#{direction == "desc" ? "icon-chevron-down" : "icon-chevron-up"}'></i>".html_safe,
            {:sort => column, :direction => direction}, {:class => css_class}
  end
  
end
