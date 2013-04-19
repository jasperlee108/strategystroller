class ProviderController < ApplicationController
  before_filter :authenticate_user!
  
  def provider_panel
    @user = current_user
  end

  def define_page
    @user = current_user
  end

  def update_page
    @user = current_user
  end
   
  def goal_define
    @user = current_user
    @goal = Goal.new
    form_id = params[:form_id]
    entry_id = params[:entry_id]
    @current_form = Form.find_by_id(form_id)
    @current_goal = Goal.find_by_id(entry_id)
    ## The following if is still faulty
    ## On success, it is redirecting to CU panel!
    if (request.post?)
      @current_form.update_attributes(:checked => true)
      @current_goal.update_attributes(params[:goal])
      redirect_to unchecked_path
    end
  end
  
  def indicator_define
    @user = current_user
    @indicator = Indicator.new
    form_id = params[:form_id]
    entry_id = params[:entry_id]
    @current_form = Form.find_by_id(form_id)
    @current_indicator = Indicator.find_by_id(entry_id)
    ## The following if is still faulty
    ## On success, it is redirecting to CU panel!
    if (request.post?)
      @current_form.update_attributes(:checked => true)
      @current_indicator.update_attributes(params[:indicator])
      redirect_to unchecked_path
    end
  end
  
  def project_define
    @user = current_user
    @project = Project.new
    form_id = params[:form_id]
    entry_id = params[:entry_id]
    @current_form = Form.find_by_id(form_id)
    @current_project = Project.find_by_id(entry_id)
    ## The following if is still faulty
    ## On success, it is redirecting to CU panel!
    if (request.post?)
      @current_form.update_attributes(:checked => true)
      @current_project.update_attributes(params[:project])
      redirect_to unchecked_path
    end
  end
  
  def activity_define
    @user = current_user
    @activity = Activity.new
    form_id = params[:form_id]
    entry_id = params[:entry_id]
    @current_form = Form.find_by_id(form_id)
    @current_activity = Activity.find_by_id(entry_id)
    ## The following if is still faulty
    ## On success, it is redirecting to CU panel!
    if (request.post?)
      @current_form.update_attributes(:checked => true)
      @current_activity.update_attributes(params[:activity])
      redirect_to unchecked_path
    end
  end
  
  def indicator_update
    @user = current_user
  end

  def project_update
    @user = current_user
  end
  
  def unchecked
    @user = current_user
    @forms = Form.where(:checked => false).find_all_by_user_id(@user.id)
  end
  
  def saved
    @user = current_user
    # do something here
  end
end
