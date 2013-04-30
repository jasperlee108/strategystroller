class ControllerUnitController < ApplicationController
  require 'base64' 
  before_filter :authenticate_user!
  #before_filter do
  # #should handle checking that a user is a cu, as of yet untested TODO test me.
    #redirect_to :new_user_session_path unless current_user && current_user.controlling_unit?
  #end

  GOAL = 1
  INDICATOR = 2
  PROJECT = 3
  ACTIVITY = 4
  MAILER = ActionMailer::Base.default_url_options

  def clean_list(listie)
    final_list = []
    i = 0
    listie.each do |k|
      y=i.times.map{0}<<k
      final_list<<y
      i = i+1
    end
    return final_list
  end

  def graph_panel
    @user = current_user
    pname_list = Project.all.map(&:name)
    pgs_list_uc = Project.all.map(&:status_global)
    len_of_list = pname_list.length
    if len_of_list>0
      max_val = pgs_list_uc.max
      axis_range = "0" + "|" + (max_val/4).to_s + "|" + (max_val/2).to_s + "|" + (3*max_val/4).to_s + "|" + max_val.to_s
      colors = len_of_list.times.map{"%06x" % (rand * 0x1000000)}
      pgs_list = pgs_list_uc.combination(1).to_a

      ### Line chart still relies on canned data.
      @line_chart = Gchart.line(:size => '600x200',:data => [300, 100, 30, 200, 100, 200, 300, 10], :axis_with_labels => 'x,r',
              :axis_labels => ['Jan|July|Jan|July|Jan', axis_range], :title => "Projects Status Trends",)

      spacing = (350/(len_of_list)).to_s + "," + (150/(len_of_list)).to_s
      @bar_chart = Gchart.bar( 
              :axis_with_labels => 'y',
              :axis_labels => [axis_range],
              :size => '500x500',
              :theme => :pastel,
              :title => "Projects Global Status",
              :bar_width_and_spacing => spacing,
              :legend => pname_list,
              :data => clean_list(pgs_list_uc))

      @pie_chart = Gchart.pie_3d(:title => 'Project Status Distribution', :size => '600x300',
                :data => pgs_list_uc, :labels => pname_list )
    end
  end

  def controller_panel
    @user = current_user
  end
  
  def goals_list
    @goals = Goal.all
  end
  
  def indicators_list
    @indicators = Indicator.all
  end
  
  def projects_list
    @projects = Project.all
  end
  
  def set_goal
    @goal = Goal.new
    if (request.post?) 
      @goal = Goal.new(params[:goal])
      @goal.status = 0
      if @goal.save # goal saved
        form_id = save_form(GOAL, @goal.user_id, @goal.id)
        if (!form_id) # goal saved but form not saved, so delete goal
          Goal.delete(Goal.find_by_id(@goal.id))
          flash[:error] = "ERROR: Goal was not saved!"
        else # goal and form saved
          provider = @goal.user.username
          flash[:notice] = "Goal successfully saved! A form has been sent to " + provider + "."
          @user_obj = User.find_by_id(@goal.user_id)
          @form_url = encode_url(form_id, @goal.id)
          #save form_url
          FormMailer.form_email(@user_obj,@form_url).deliver #Mail confirmation to each saved user
        end
      else # goal not saved
        flash[:error] = "ERROR: Goal was not saved!"
      end
      redirect_to cu_review_path
    end
  end
  
  def set_indicator
    @indicator = Indicator.new
    if (request.post?) 
      @indicator = Indicator.new(params[:indicator])
      @indicator.status = 0
      if @indicator.save # indicator saved
        form_id = save_form(INDICATOR, @indicator.user_id, @indicator.id)
        if (!form_id) # indicator saved but form not saved, so delete indicator
          Indicator.delete(Indicator.find_by_id(@indicator.id))
          flash[:error] = "ERROR: Indicator was not saved!"
        else # indicator and form saved
          provider = @indicator.user.username
          flash[:notice] = "Indicator successfully saved! A form has been sent to " + provider + "."
          @user_obj = User.find_by_id(@indicator.user_id)
          # Need to populate a form
          @form_url = encode_url(form_id, @indicator.id)
          FormMailer.form_email(@user_obj,@form_url).deliver #Mail confirmation to each saved user
        end
      else # indicator not saved
        flash[:error] = "ERROR: Indicator was not saved!"
      end
      redirect_to cu_review_path
    end
  end
  
  def set_project
    @project = Project.new
    if (request.post?)
      @project = Project.new(params[:project])
      # Put some (important) default values
      @project.startDate = Date.current
      @project.endDate = Date.tomorrow
      @project.status_cost = 0
      @project.status_global = 0
      @project.status_manp = 0
      @project.status_ms = 0
      @project.status_prog = 0
      if @project.save # project saved
        form_id = save_form(PROJECT, @project.head_id, @project.id)
        if (!form_id) # project saved but form not saved, so delete project
          Project.delete(Project.find_by_id(@project.id))
          flash[:error] = "ERROR: Project was not saved!"
        else # project and form saved
          provider = @project.head.username
          flash[:notice] = "Project successfully saved! A form has been sent to " + provider + "."
          @user_obj = User.find_by_id(@project.head_id)
          # Need to populate a form
          @form_url = encode_url(form_id, @project.id)
          FormMailer.form_email(@user_obj,@form_url).deliver #Mail confirmation to each saved user
        end
      else # project not saved
        flash[:error] = "ERROR: Project was not saved!"
      end
      redirect_to cu_review_path
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

    def encode_id(id) 
      encoded = Base64.encode64(id.to_s)
      return encoded
    end

    def encode_url(form_id, entry_id) #only for provider define (so far)
      encoded_form_id = encode_id(form_id.to_s)
      encoded_entry_id = encode_id(entry_id.to_s)
      form = Form.find_by_id(form_id)
      lookup = form.lookup
      if (lookup == GOAL) 
        category = "goal"
      elsif (lookup == INDICATOR)
        category = "indicator"
      elsif (lookup == PROJECT)
        category = "project"
      elsif (lookup ==  ACTIVITY)
        category = "activity"
      end
      url = MAILER[:host] + "/provider/" + category + "_define?entry_id=" + encoded_entry_id + "&form_id=" + encoded_form_id #temp
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

  def cu_review
    @user = current_user
    @forms = Form.where(:checked => true, :reviewed => false, :submitted => true)
  end

  def activity_list
    @activities = Activity.all
  end

  def view_activity
    @activity = Activity.find_by_id(params[:activity_id])
  end

  def goal_check
    @user = current_user
    @goal = Goal.new
    form_id = params[:form_id]
    entry_id = params[:entry_id]
    @current_form = Form.find_by_id(form_id)
    @current_goal = Goal.find_by_id(entry_id)
    @indicators = (@current_goal.indicators).collect{|i| i.short_name}
    @indicators.empty? ? @indicators += ['None'] : nil
    @prerequisites = (Goal.select('short_name')).select{|g| g.short_name != @current_goal.short_name}.collect{|g| g.short_name}
    if (request.post?)
      @current_form.update_attributes(:reviewed => true)
      @current_goal.update_attributes(params[:goal])
      flash[:notice] = "Goal review completed!"
      redirect_to cu_review_path
    end
  end
  
  def indicator_check
    @user = current_user
    @indicator = Indicator.new
    form_id = params[:form_id]
    entry_id = params[:entry_id]
    @current_form = Form.find_by_id(form_id)
    @current_indicator = Indicator.find_by_id(entry_id)
    @projects = (@current_indicator.projects).collect{|p| p.short_name}
    @projects.empty? ? @projects += ['None'] : nil
    if (request.post?)
      @current_form.update_attributes(:reviewed => true)
      @current_indicator.update_attributes(params[:indicator])
      flash[:notice] = "Indicator review completed!"
      redirect_to cu_review_path
    end
  end
  
  def project_check
    @user = current_user
    @project = Project.new
    form_id = params[:form_id]
    entry_id = params[:entry_id]
    @current_form = Form.find_by_id(form_id)
    @current_project = Project.find_by_id(entry_id)
    @activities = @current_project.activities
    @project.startDate = @current_project.startDate
    if (request.post?)
      @current_form.update_attributes(:reviewed => true)
      @current_project.update_attributes(params[:project])
      flash[:notice] = "Project review completed!"
      redirect_to cu_review_path
    end
  end

   def save_form(table_id, user_id, entry_id)
    default = [GOAL,INDICATOR,PROJECT,ACTIVITY]
    if default.include? table_id
      @form = create_form(false, table_id, false, user_id, false, Date.today, entry_id)
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

  ### DISPLAY ALL DATA FOR OVERVIEW PAGE + RELATED METHODS ###

  def all_data
    @user = current_user
    @goal_ids = []
    @indicator_ids = []
    @project_ids = []
  end

  def all_activity
    @activity = Activity.find_by_id(params[:activity_id])
  end
  
  def all_project
    @project = Project.find_by_id(params[:project_id])
    @activities = @project.activities
  end
  
  def all_indicator
    @indicator = Indicator.find_by_id(params[:indicator_id])
    @projects = (@indicator.projects).collect{|p| p.short_name}
    @projects.empty? ? @projects += ['None'] : nil
  end
  
  def all_goal
    @goal = Goal.find_by_id(params[:goal_id])
    @indicators = (@goal.indicators).collect{|i| i.short_name}
    @indicators.empty? ? @indicators += ['None'] : nil
    @prerequisites = (Goal.select('short_name')).select{|g| g.short_name != @goal.short_name}.collect{|g| g.short_name}
  end
  
  def all_dimension
    @dimension = Dimension.find_by_id(params[:dimension_id])
  end
  
end
