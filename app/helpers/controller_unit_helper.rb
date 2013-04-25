module ControllerUnitHelper
  
  ## INFO
  GOAL = 1
  INDICATOR = 2
  PROJECT = 3
  ACTIVITY = 4
  
  def find_label(table_id)
    if table_id == GOAL
      return "Show Goal Form"
    elsif table_id == INDICATOR
      return "Show Indicator Form"
    elsif table_id == PROJECT
      return "Show Project Form"
    elsif table_id == ACTIVITY
      return "Show Activity Form"
    else
      ## ERROR: Should not reach here!
      return "Show what?"
    end
  end
  
  def form_type(table_id)
    if table_id == GOAL
      return "Goal"
    elsif table_id == INDICATOR
      return "Indicator"
    elsif table_id == PROJECT
      return "Project"
    elsif table_id == ACTIVITY
      return "Activity"
    else
      ## ERROR: Should not reach here!
      return "Show what?"
    end
  end
  
  def find_set_path_cu(table_id, entry_id)
    if table_id == GOAL
      return set_goal_path()
    elsif table_id == INDICATOR
      return set_indicator_path()
    elsif table_id == PROJECT
      return set_project_path()
    elsif table_id == ACTIVITY
      return set_activity_path()
    else
      ## ERROR: Should not reach here!
      return cu_review_path
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
  
end
