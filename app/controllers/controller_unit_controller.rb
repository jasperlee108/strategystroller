class ControllerUnitController < ApplicationController
  before_filter :authenticate_user!
  #before_filter do
  # #should handle checking that a user is a cu, as of yet untested TODO test me.
    #redirect_to :new_user_session_path unless current_user && current_user.controlling_unit?
  #end

  ## INFO
  GOAL = 1
  INDICATOR = 2
  PROJECT = 3
  ACTIVITY = 4

  def welcome
    @user = current_user
  end
  
  def set_goal
    @goal = Goal.new
    if (request.post?) 
      @goal = Goal.new(params[:goal])
      result = save_form(GOAL, current_user.id)
      if result.include? "ERROR"
        flash[:error] = result + ' ' + "ERROR: Goal was not saved!"
      elsif @goal.save
        flash[:notice] = result + ' ' + " Goal successfully saved!"
      else
        flash[:error] = result + ' ' + "ERROR: Goal was not saved!"
      end
      redirect_to goals_path
    end
  end
  
  def set_indicator
    @indicator = Indicator.new
    if (request.post?) 
      @indicator = Indicator.new(params[:indicator])
      result = save_form(INDICATOR, current_user.id)
      if result.include? "ERROR"
        flash[:error] = result + ' ' + "ERROR: Indicator was not saved!"
      elsif @indicator.save
        flash[:notice] = result + ' ' + " Indicator successfully saved!"
      else
        flash[:error] = result + ' ' + "ERROR: Indicator was not saved!"
      end
      redirect_to indicators_path
    end
  end
  
  def set_project
    @project = Project.new
    if (request.post?) 
      @project = Project.new(params[:project])
      result = save_form(PROJECT, current_user.id)
      if result.include? "ERROR"
        flash[:error] = result + ' ' + "ERROR: Project was not saved!"
      elsif @project.save
        flash[:notice] = result + ' ' + " Project successfully saved!"
      else
        flash[:error] = result + ' ' + "ERROR: Project was not saved!"
      end
      redirect_to projects_path
    end
  end
  
  def set_activity
    @activity = Activity.new
    if (request.post?) 
      @activity = Activity.new(params[:activity])
      result = save_form(ACTIVITY, current_user.id)
      if result.include? "ERROR"
        flash[:error] = result + ' ' + "ERROR: Activity was not saved!"
      elsif @activity.save
        flash[:notice] = result + ' ' + " Activity successfully saved!"
      else
        flash[:error] = result + ' ' + "ERROR: Activity was not saved!"
      end
      redirect_to activities_path
    end
  end
  
  def setup_system
    @application = Application.new
    @years = Application::YEARS
    @languages = Application::LANGUAGES
    @time_horizon = Application::TIME_HORIZON
    if (request.post?) 
      @application = Application.new(params[:application])
      if @application.save
        # No longer a TODO--can remove user-related details 
        # TODO: save each user entered in the User table once User creation
        # changed such that a user can be saved without a password
  
        # users = params[:users_attributes]
        # for id in users do
        #     user_hash = users[id]
        #     username = user_hash[:username]
        #     email = user_hash[:email]
  
        flash[:notice] = "Setup successfully saved!"
      else
        flash[:error] = "Setup was not saved"
        return
      end
  
      users = params[:users]
      count = 0
      total = 0
      users.each do |info|
        total += 1
        user = User.new(info)
        if !user.save
          count+= 1
        end
      end
  
      if (count != total)
        flash[:error] = count + " users not saved"
      else
        flash[:notice] = "All users successfully saved!"
      end
      
    end
  end
  
  def edit_users
    @user = User.new
  end

  def save_form(table_id, user_id)
    default = [GOAL,INDICATOR,PROJECT,ACTIVITY]
    if default.include? table_id
      @form = create_form(false, table_id, false, user_id)
      if @form.save
        return "Form successfully saved!"
      else
        return "ERROR: Form cannot be saved!"
      end
    else
      # ERROR: wrong table_id
      return "ERROR: Wrong table id!"
    end
  end

  def create_form(checked, table_id, reviewed, user_id)
    form = Form.new(
    :checked => checked,
    :lookup => table_id,
    :reviewed => reviewed,
    :user_id => user_id
    )
    return form
  end

end
