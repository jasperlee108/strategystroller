module ApplicationHelper
  
  # Put here so CU controller and Provider controller can both use it
  
  ## INFO
  GOAL = 1
  INDICATOR = 2
  PROJECT = 3
  ACTIVITY = 4
  
  def find_truth_value(truth)
    if truth
      return "Yes"
    end
    return "No"
  end

  def find_label(table_id, entry_id)
    if table_id == GOAL
      return Goal.find_by_id(entry_id).short_name
    elsif table_id == INDICATOR
      return Indicator.find_by_id(entry_id).short_name
    elsif table_id == PROJECT
      return Project.find_by_id(entry_id).short_name
    elsif table_id == ACTIVITY
      return Activity.find_by_id(entry_id).short_name
    else
      ## ERROR: Should not reach here!
      return "ERROR: Show what?"
    end
  end
  
  def find_form_type(lookup_id)
    if lookup_id == GOAL
      return "Goal"
    elsif lookup_id == INDICATOR
      return "Indicator"
    elsif lookup_id == PROJECT
      return "Project"
    elsif lookup_id == ACTIVITY
      return "Activity"
    else
      ## ERROR: Should not reach here!
      return "ERROR: Cannot find table!"
    end
  end
  
  # Following code is taken from:
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
