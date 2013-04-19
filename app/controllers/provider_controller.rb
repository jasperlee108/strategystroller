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
    if request.post?
      @current_form.update_attributes(:checked => true)
      @current_goal.update_attributes(params[:goal])
      redirect_to unchecked_path
    end
  end
  
  def indicator_define
    @user = current_user
  end
  
  def activity_define
    @user = current_user
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
