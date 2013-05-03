module ControllerUnitHelper
  
  ## INFO
  GOAL = 1
  INDICATOR = 2
  PROJECT = 3
  ACTIVITY = 4
   
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
  
  
end
