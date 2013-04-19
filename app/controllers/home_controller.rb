class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @user = current_user
    if @user.controlling_unit
      redirect_to controller_panel_path
    else
      redirect_to provider_panel_path
    end
  end
end
