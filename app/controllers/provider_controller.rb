class ProviderController < ApplicationController
  before_filter :authenticate_user!

  def encode_url(form_id)
    encoded_id = encode_id(form_id.to_s)
    url = "http://localhost:3000/forms?form_id=" + encoded_id.to_s #TEMP
  end

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
    @current_form.update_attributes(:checked => true)
    if (request.post?)
      if (params[:commit] == "Submit Goal")
        @current_form.update_attributes(:submitted => true)
        flash[:notice] = "Goal successfully submitted!"
      elsif (params[:commit] == "Save Goal")
        flash[:notice] = "Goal successfully saved!"
      end
      @current_goal.update_attributes(params[:goal])
      redirect_to forms_composite_path
    end
  end
  
  def indicator_define
    @user = current_user
    @indicator = Indicator.new
    form_id = params[:form_id]
    entry_id = params[:entry_id]
    @current_form = Form.find_by_id(form_id)
    @current_indicator = Indicator.find_by_id(entry_id)
    @current_form.update_attributes(:checked => true)
    @goal_short_names = (Goal.select('short_name')).collect{|g| g.short_name}
    if (request.post?)
      if (params[:commit] == "Submit Indicator")
        @current_form.update_attributes(:submitted => true)
        flash[:notice] = "Indicator successfully submitted!"
      elsif (params[:commit] == "Save Indicator")
        flash[:notice] = "Indicator successfully saved!"
      end
      @current_indicator.update_attributes(params[:indicator])
      redirect_to forms_composite_path
    end
  end
  
  def project_define
    session[:return_to] = request.url
    @user = current_user
    @project = Project.new
    form_id = params[:form_id]
    entry_id = params[:entry_id]
    @current_form = Form.find_by_id(form_id)
    @current_project = Project.find_by_id(entry_id)
    @current_form.update_attributes(:checked => true)
    @activities = @current_project.activities
    if (request.post?)
      if (params[:commit] == "Submit Project")
        @current_form.update_attributes(:submitted => true)
        flash[:notice] = "Project successfully submitted!"
      elsif (params[:commit] == "Save Project")
        flash[:notice] = "Project successfully saved!"
      end
      @current_project.update_attributes(params[:project])
      redirect_to forms_composite_path
    end
  end
  
  def activity_define
    @user = current_user
    @activity = Activity.new
    @project_id = params[:project_id]
    if (request.post?)
      # NOTE: activity don't need to be in form table
      # We can directly do lookup on activity table
      @activity = Activity.new(params[:activity])
      if @activity.save # activity saved
        flash[:notice] = "Activity successfully saved!"
      else # activity not saved
        flash[:error] = "ERROR: Activity was not saved!"
      end
      if session[:return_to]
         redirect_to session[:return_to]
      else
        redirect_to activities_path
      end
    end
  end
  
  def indicator_update
    @user = current_user
  end

  def project_update
    @user = current_user
  end
  
  def forms_composite
    @user = current_user
    @forms_unchecked = Form.where(:checked => false, :submitted=>false).find_all_by_user_id(@user.id)
    @forms_saved = Form.where(:checked => true, :submitted=>false).find_all_by_user_id(@user.id)
  end
  
  
end
