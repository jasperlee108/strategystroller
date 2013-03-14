class ControllerUnitController < ApplicationController
  before_filter :authenticate_user!
  before_filter do
    #should handle checking that a user is a cu, as of yet untested TODO test me.
    redirect_to :new_user_session_path unless current_user && current_user.controlling_unit?
  end
end
