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
    # do something here
  end
  
  def saved
    @user = current_user
    # do something here
  end
end
