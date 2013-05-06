class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  ## Moved following methods here from CU controller
  ## For better OOP & easier to reuse in any class that inherits from ApplicationController
  
  ## INFO
  GOAL = 1
  INDICATOR = 2
  PROJECT = 3
  ACTIVITY = 4
  
def set_locale
  I18n.locale = params[:locale] || I18n.default_locale
end
def default_url_options(options={})
  logger.debug "default_url_options is passed options: #{options.inspect}\n"
  { :locale => I18n.locale }
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
          :last_reminder => Date.current,
          :entry_id => entry_id
      )
      if @form.save
        return @form.id
      end
    end
    # ERROR: wrong table_id or form.save failed
    return nil
  end


end
