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
                flash[:error] = "ERROR: Goal was not saved!"
            end
            redirect_to goals_path
        end
    end

    def set_indicator
        @indicator = Indicator.new
        if (request.post?) 
            @indicator = Indicator.new(params[:indicator])
            if @indicator.save
                flash[:notice] = "Indicator successfully saved!"
            else
                flash[:error] = "ERROR: Indicator was not saved!"
            end
            redirect_to indicators_path
        end
    end

    def set_project
        @project = Project.new
        if (request.post?) 
            @project = Project.new(params[:project])
            if @project.save
                flash[:notice] = "Project successfully saved!"
            else
                flash[:error] = "ERROR: Project was not saved!"
            end
            redirect_to projects_path
        end
    end

    def set_dimension
        @dimension = Dimension.new
        if (request.post?) 
            @dimension = Dimension.new(params[:dimension])
            if @dimension.save
                flash[:notice] = "Dimension successfully saved!"
            else
                flash[:error] = "ERROR: Dimension was not saved!"
            end
            redirect_to dimensions_path
        end
    end

    def set_activity
        @activity = Activity.new
        if (request.post?) 
            @activity = Activity.new(params[:activity])
            if @activity.save
                flash[:notice] = "Activity successfully saved!"
            else
                flash[:error] = "ERROR: Activity was not saved!"
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
                flash[:notice] = "Setup successfully saved!"
            else
                flash[:error] = "ERROR: Setup was not saved"
                return
            end
        end
    end

    def create_users
       @application = Application.new #Just using Application model because cocoon needs a users field
        if (request.post?)
            app = params[:application]
            if (app != nil)
                users_hash = app[:users_attributes] #hash of hashes

                numSaved = 0 
                total = 0 #number of users that should be saved
                notSaved = []

                users_hash.each do |key, value|
                    username = users_hash[key][:username]
                    email = users_hash[key][:email]
                    if (email != "" && username != "") #quick check not from empty input boxes (or invalid)
                        total += 1
                        user = User.new(:username => username, :email => email, :password => "password", :business_code=>"xx")
                        if user.save
                            numSaved += 1
                        else
                            notSaved << email
                        end
                    end
                end     

                if (numSaved == 0 && total == 0) #empty input boxes
                    flash[:notice] = "Please enter Username and Email"
                elsif (numSaved == total) #tried to save valid inputs and success!
                    flash[:notice] = "All users successfully saved!"
                else #some users could not be saved
                    user_string = ""
                    notSaved.each do |user|
                        user_string = user_string + user + ", "
                    end
                    user_string.slice!(user_string.length - 2)
                    flash[:notice] = "User(s) " + user_string + "already exist(s) so not saved."
                end
            else
                flash[:notice] = "No users saved"
            end
         end
    end
end
