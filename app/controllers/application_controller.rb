class ApplicationController < ActionController::Base
  protect_from_forgery
  
  ## Moved following methods here from CU controller
  ## For better OOP & easier to reuse in any class that inherits from ApplicationController
  
  ## INFO
  GOAL = 1
  INDICATOR = 2
  PROJECT = 3
  ACTIVITY = 4
  
  def save_form(table_id, user_id, entry_id)
    default = [GOAL,INDICATOR,PROJECT,ACTIVITY]
    if default.include? table_id
      @form = create_form(false, table_id, false, user_id, false, Date.current, entry_id)
      if @form.save
        return @form.id
      end
    end
    # ERROR: wrong table_id or form.save failed
    return nil
  end

  def create_form(checked, table_id, reviewed, user_id, submitted, last, entry_id)
    form = Form.new(
    :checked => checked,
    :lookup => table_id,
    :reviewed => reviewed,
    :user_id => user_id,
    :submitted => submitted,
    :last_reminder => last,
    :entry_id => entry_id
    )
    return form
  end
  
end
