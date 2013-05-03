module ControllerUnitHelper
  
  ## INFO
  GOAL = 1
  INDICATOR = 2
  PROJECT = 3
  ACTIVITY = 4
  
  def find_label_cu(table_id, entry_id)
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
   
   
  def find_path_cu(table_id, entry_id, form_id)
    if table_id == GOAL
      return goal_check_path(:entry_id => entry_id, :form_id => form_id)
    elsif table_id == INDICATOR
      return indicator_check_path(:entry_id => entry_id, :form_id => form_id)
    elsif table_id == PROJECT
      return project_check_path(:entry_id => entry_id, :form_id => form_id)
    elsif table_id == ACTIVITY
      return activity_check_path(:entry_id => entry_id, :form_id => form_id)
    else
      ## ERROR: Should not reach here!
      return cu_review_path
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
  
  
  def find_truth_value(truth)
    if truth
      return "Yes"
    end
    return "No"
  end
  
  
end
