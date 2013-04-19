class ControllerUnitController < ApplicationController
  require 'base64' 
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

  def controller_panel
    @user = current_user
  end
  
  def set_goal
    @goal = Goal.new
    if (request.post?) 
      @goal = Goal.new(params[:goal])
      if @goal.save #goal saved
        form_id = save_form(GOAL, @goal.user_id, @goal.id)
        if (!form_id) #form not saved
          Goal.delete(@goal) # rollback: delete goal
          flash[:error] = "ERROR: Goal was not saved!"
        else
          @user_obj = User.find_by_id(@goal.user_id)
          # Need to populate a form
          @form_url = encode_url(form_id)
          FormMailer.form_email(@user_obj,@form_url).deliver #Mail confirmation to each saved user
          flash[:notice] = "Goal successfully saved!"
        end
      else #goal not saved
        flash[:error] = "ERROR: Goal was not saved!"
      end
      redirect_to goals_path
    end
  end
  
  def set_indicator
    @indicator = Indicator.new
    if (request.post?) 
      @indicator = Indicator.new(params[:indicator])
      form_id = save_form(INDICATOR, @indicator.user_id, @indicator.id)
      if (!form_id) #form not saved
        flash[:error] = "ERROR: Indicator was not saved!"
      elsif @indicator.save #form saved and indicator saved
        flash[:notice] = "Indicator successfully saved!"
        @user_obj = User.find_by_id(@indicator.user_id)
        # Need to populate a form
        @form_url = encode_url(form_id)
        FormMailer.form_email(@user_obj,@form_url).deliver #Mail confirmation to each saved user
      else #form saved but indicator not saved, so delete form
        Form.delete(Form.find_by_id(form_id))
        flash[:error] = "ERROR: Indicator was not saved!"
      end
      redirect_to indicators_path
    end
  end
  
  def set_project
    @project = Project.new
    if (request.post?) 
      @project = Project.new(params[:project])
      form_id = save_form(PROJECT, @project.head_id, @project.id)
      if (!form_id) #form not saved
        flash[:error] = "ERROR: Project was not saved!"
      elsif @project.save #form saved and project saved
        flash[:notice] = "Project successfully saved!"
        @user_obj = User.find_by_id(@project.head_id)
        # Need to populate a form
        @form_url = encode_url(form_id)
        FormMailer.form_email(@user_obj,@form_url).deliver #Mail confirmation to each saved use
      else #form saved but project not saved, so delete form
        Form.delete(Form.find_by_id(form_id))
        flash[:error] = "ERROR: Project was not saved!"
      end
      redirect_to projects_path
    end
  end
  
  def set_activity #Belongs in Provider Panel?
    @activity = Activity.new
    if (request.post?) 
      @activity = Activity.new(params[:activity])
      form_id = save_form(ACTIVITY, nil, @activity.id)
      if (!form_id) #form not saved
        flash[:error] = "ERROR: Activity was not saved!"
      elsif @activity.save #form saved and activity saved
        flash[:notice] = "Activity successfully saved!"
        form = Form.find_by_id(form_id)
        form.submitted = true
        form.checked = true
        form.save
      else #form saved but activity not saved, so delete form
        Form.delete(Form.find_by_id(form_id))
        flash[:error] = "ERROR: Activity was not saved!"
      end
      redirect_to activities_path
    end
  end
  
  def applications
    @application = Application.new
    if (request.post?)
      if (params[:commit] == 'Save Setup')
          redirect_to "/controller_unit/setup_system"
          setup_system
      elsif (params[:commit] == 'Create User(s)')
          redirect_to "/controller_unit/create_users"
          create_users
      elsif (params[:commit] == 'Remove User(s)')
          redirect_to "/controller_unit/remove_users"
          remove_users
      end
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

    def encode_id(form_id) #helper method for encode_url
      encoded = Base64.encode64(form_id.to_s)
      return encoded
    end

    def encode_url(form_id)
      encoded_id = encode_id(form_id.to_s)
      url = "http://localhost:3000/forms?form_id=" + encoded_id.to_s #TEMP
    end

    def decode_id(form_id)
      decoded = Base64.decode64(form_id.to_s)
      return decoded
    end

    def extract_id(url)
      id = url.split("form_id=")[1]
      return id
    end  


    def create_users
       @application = Application.new #Just using Application model because it has a 'users' field that cocoon needs
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
                      
                        temp_password = SecureRandom.hex
                        cu = users_hash[key][:controlling_unit]
                        user = User.new(:username => username, :email => email, :password => temp_password, :temp_password => temp_password, :controlling_unit => cu)
                        if user.save
                            numSaved += 1
                           user.send_confirmation_instructions #TODO TEST
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
                    flash[:notice] = "User(s) " + user_string + "already exist(s). All other users successfully created!"
                end
            else
                flash[:notice] = "No users saved"
            end
         end
    end

    def remove_users
         @application = Application.new #Just using Application model because it has a 'users' field that cocoon needs
        if (request.post?)
            app = params[:application]
            if (app != nil)
                users_hash = app[:users_attributes] #hash of hashes

                numDeleted = 0 
                total = 0 #number of users that should be deleted
                notDeleted = []
                #here
                users_hash.each do |key, value|
                    email = users_hash[key][:email]
                    if (email != "") #quick check not from empty input boxes (or invalid)
                        total += 1
                        user = User.find_by_email(email)

                        if (user) #user with this email exists
                          User.delete(user)
                          if (!User.find_by_email(email)) #not successfully deleted, perhaps redundant check
                              numDeleted += 1
                          else
                              notDeleted << email
                          end
                        else
                          notDeleted << email
                        end
                    end

                end     

                if (numDeleted == 0 && total == 0) #empty input boxes
                    flash[:notice] = "Please enter Email"
                elsif (numDeleted == total) #tried to delete valid inputs and success!
                    flash[:notice] = "All users successfully removed!"
                else #some users could not be deleted
                    user_string = ""
                    notDeleted.each do |user|
                        user_string = user_string + user + ", "
                    end
                    user_string.slice!(user_string.length - 2)
                    flash[:notice] = "User(s) " + user_string + "do(es) not exist. All other users successfully removed!"
                end
            else
                flash[:notice] = "No users removed"
            end
         end
    end

  def save_form(table_id, user_id, entry_id)
    default = [GOAL,INDICATOR,PROJECT,ACTIVITY]
    if default.include? table_id
      @form = create_form(false, table_id, false, user_id, false, Date.current, entry_id)
      if @form.save
        return @form.id
      else
        return nil
      end
    else
      # ERROR: wrong table_id
      return nil
    end
  end

  def create_form(checked, table_id, reviewed, user_id, submitted, last, entry_id)
    form = Form.new(
    :checked => checked,
    :lookup => table_id,
    :reviewed => reviewed,
    :user_id => user_id,
    :submitted => submitted,
    :last_reminder => last,
    :entry_id => entry_id
    )
    return form
  end

  def cu_review
    @user = current_user
    @forms = Form.where(:checked => true, :reviewed => false, :submitted => true)
  end

def goal_check
  @user = current_user
  @goal = Goal.new
  form_id = params[:form_id]
  entry_id = params[:entry_id]
  @current_form = Form.find_by_id(form_id)
  @current_goal = Goal.find_by_id(entry_id)
  ## The following if is still faulty
  ## On success, it is redirecting to CU panel!
  if (request.post?)
    @current_form.update_attributes(:reviewed => true)
    @current_goal.update_attributes(params[:goal])
    redirect_to cu_review
  end
end

def indicator_check
  @user = current_user
  @indicator = Indicator.new
  form_id = params[:form_id]
  entry_id = params[:entry_id]
  @current_form = Form.find_by_id(form_id)
  @current_indicator = Indicator.find_by_id(entry_id)
  ## The following if is still faulty
  ## On success, it is redirecting to CU panel!
  if (request.post?)
    @current_form.update_attributes(:reviewed => true)
    @current_goal.update_attributes(params[:indicator])
    redirect_to cu_review
  end
end

def project_check
  @user = current_user
  @project = Project.new
  form_id = params[:form_id]
  entry_id = params[:entry_id]
  @current_form = Form.find_by_id(form_id)
  @current_project = Project.find_by_id(entry_id)
  ## The following if is still faulty
  ## On success, it is redirecting to CU panel!
  if (request.post?)
    @current_form.update_attributes(:reviewed => true)
    @current_goal.update_attributes(params[:project])
    redirect_to cu_review
  end
end

def activity_check
  @user = current_user
  @activity = Activity.new
  form_id = params[:form_id]
  entry_id = params[:entry_id]
  @current_form = Form.find_by_id(form_id)
  @current_activity = Activity.find_by_id(entry_id)
  ## The following if is still faulty
  ## On success, it is redirecting to CU panel!
  if (request.post?)
    @current_form.update_attributes(:reviewed => true)
    @current_goal.update_attributes(params[:activity])
    redirect_to cu_review
  end
end

end
