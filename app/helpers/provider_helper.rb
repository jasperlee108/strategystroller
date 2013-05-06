module ProviderHelper
  
  ## INFO
  GOAL = 1
  INDICATOR = 2
  PROJECT = 3
  
  def find_path(table_id, entry_id, form_id)
    if table_id == GOAL
      return goal_define_path(:entry_id => entry_id, :form_id => form_id)
    elsif table_id == INDICATOR
      return indicator_define_path(:entry_id => entry_id, :form_id => form_id)
    elsif table_id == PROJECT
      return project_define_path(:entry_id => entry_id, :form_id => form_id)
    else
      ## ERROR: Should not reach here!
      return forms_composite_path
    end
  end

  def find_update_path(table_id, entry_id, form_id)
    if table_id == INDICATOR
      return indicator_update_path(:entry_id => entry_id, :form_id => form_id)
    elsif table_id == PROJECT
      return project_update_path(:entry_id => entry_id, :form_id => form_id)
    else
      ## ERROR: Should not reach here!
      return forms_composite_update_path
    end
  end
  
end
