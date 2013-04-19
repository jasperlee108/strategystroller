class ProviderController < ApplicationController
  before_filter :authenticate_user!
  
  def provider_panel
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
