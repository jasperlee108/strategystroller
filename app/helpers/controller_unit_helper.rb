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
    else
      ## ERROR: Should not reach here!
      return cu_review_path
    end
  end

  def save_form(table_id, user_id, entry_id)
    default = [GOAL,INDICATOR,PROJECT,ACTIVITY]
    if default.include? table_id
      @form = Form.new(
          :checked => false,
          :lookup => table_id,
          :reviewed => false,
          :user_id => user_id,
          :submitted => false,
          :last_reminder => Date.today,
          :entry_id => entry_id
      )
      if @form.save
        return @form.id
      else   # FIXME due to the validations in form and the if above, this cannot be reached by this method.
        return nil
      end
    else
      # ERROR: wrong table_id
      return nil
    end
  end

end
