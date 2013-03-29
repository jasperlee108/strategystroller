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
            @goal = Goal.new(params[:goal])
            if @goal.save
                flash[:notice] = "Goal successfully saved!"
            else
                flash[:error] = "Goal was not saved"
            end
        end
    end

    def set_indicator
        @indicator = Indicator.new
        if (request.post?) 
            @indicator = Indicator.new(params[:indicator])
            if @indicator.save
                flash[:notice] = "Indicator successfully saved!"
            else
                flash[:error] = "Indicator was not saved"
            end
        end
    end

    def set_project
        @project = Project.new
        if (request.post?) 
            @project = Project.new(params[:project])
            if @project.save
                flash[:notice] = "Project successfully saved!"
            else
                flash[:error] = "Project was not saved"
            end
        end
    end

end
