class ControllerUnitController < ApplicationController
  before_filter :authenticate_user!
  #before_filter do
  # #should handle checking that a user is a cu, as of yet untested TODO test me.
    #redirect_to :new_user_session_path unless current_user && current_user.controlling_unit?
  #end

   def welcome
     @user = current_user
   end

    def set_goal
        @goal = Goal.new
        if (request.post?) 
            hash = params[:goal]
            hash = hash.merge(:status => 0)
            @goal = Goal.new(hash)
            if @goal.save
                flash[:notice] = "Goal successfully saved!"
            else
                flash[:error] = "Goal was not saved"
            end
        end
    end

end
