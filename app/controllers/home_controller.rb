class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @user = current_user
    if @user.controlling_unit
      redirect_to cu_review_path
    else
      redirect_to forms_composite_path
    end
  end
end
