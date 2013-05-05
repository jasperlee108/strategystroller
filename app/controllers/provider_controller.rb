class ProviderController < ApplicationController
  before_filter :authenticate_user!
  helper_method :sort_column, :sort_direction
  
  MAILER = ActionMailer::Base.default_url_options

 # def encode_url(form_id)
  #  encoded_id = encode_id(form_id.to_s)
   # url = "http://localhost:3000/forms?form_id=" + encoded_id.to_s #TEMP
  #end

  GOAL = 1
  INDICATOR = 2
  PROJECT = 3
  ACTIVITY = 4
   
  def goal_define
    @user = current_user
    @goal = Goal.new
    form_id = params[:form_id]
    entry_id = params[:entry_id]
    @current_form = Form.find_by_id(form_id)
    @current_goal = Goal.find_by_id(entry_id)
    @current_form.update_attributes(:checked => true, :updated_at => Time.current)
    if (request.post?)
      if (params[:commit] == "Submit Goal")
        @current_form.update_attributes(:submitted => true, :updated_at => Time.current)
        flash[:notice] = "Goal successfully submitted!"
      elsif (params[:commit] == "Save Goal")
        flash[:notice] = "Goal successfully saved!"
      end
      @current_goal.update_attributes(params[:goal], :updated_at => Time.current)
      redirect_to forms_composite_path
    end
  end
  
  def indicator_define
    @user = current_user
    @indicator = Indicator.new
    form_id = params[:form_id]
    entry_id = params[:entry_id]
    @current_form = Form.find_by_id(form_id)
    @current_indicator = Indicator.find_by_id(entry_id)
    @current_form.update_attributes(:checked => true, :updated_at => Time.current)
    @goal_short_names = (Goal.select('short_name')).collect{|g| g.short_name}
    if (request.post?)
      if (params[:commit] == "Submit Indicator")
        @current_form.update_attributes(:submitted => true, :updated_at => Time.current)
        flash[:notice] = "Indicator successfully submitted!"
      elsif (params[:commit] == "Save Indicator")
        flash[:notice] = "Indicator successfully saved!"
      end
      redirect_to forms_composite_path
    end
  end
  
  def project_define
    session[:return_to] = request.url
    @user = current_user
    @project = Project.new
    form_id = params[:form_id]
    entry_id = params[:entry_id]
    @current_form = Form.find_by_id(form_id)
    @current_project = Project.find_by_id(entry_id)
    @current_form.update_attributes(:checked => true, :updated_at => Time.current)
    @activities = @current_project.activities
    if (request.post?)
      if (params[:commit] == "Submit Project")
        @current_form.update_attributes(:submitted => true, :updated_at => Time.current)
        flash[:notice] = "Project successfully submitted!"
      elsif (params[:commit] == "Save Project")
        flash[:notice] = "Project successfully saved!"
      end
      @current_project.update_attributes(params[:project], :updated_at => Time.current)
      redirect_to forms_composite_path
    end
  end
  
  def activity_define
    @user = current_user
    @activity = Activity.new
    @project_id = params[:project_id]
    if (request.post?)
      # NOTE: activity don't need to be in form table
      # We can directly do lookup on activity table
      @activity = Activity.new(params[:activity])
      if @activity.save! # activity saved
        flash[:notice] = "Activity successfully saved!"
      else # activity not saved
        flash[:error] = "ERROR: Activity was not saved!"
      end
      if session[:return_to]
         redirect_to session[:return_to]
      else
        redirect_to activities_path
      end
    end
  end
  
  def indicator_update
    @user = current_user
    @indicator = Indicator.new
    form_id = params[:form_id]
    entry_id = params[:entry_id]
    @current_form = Form.find_by_id(form_id)
    @current_indicator = Indicator.find_by_id(entry_id)
    @projects = (@current_indicator.projects).collect{|p| p.short_name}
    @projects.empty? ? @projects += ['None'] : nil
    if (request.post? || request.put?)
      params[:indicator][:freq].delete_if{|k,v| k==""}
      params[:indicator][:freq].map! do |month|
          month = month.to_i
      end
      if (params[:commit] == "Update Indicator")
        @current_indicator.update_attributes(params[:indicator], :updated_at => Time.current)
        flash[:notice] = "Indicator successfully submitted!"
      elsif (params[:commit] == "Save Indicator")
        @current_indicator.update_attributes(params[:indicator]) #don't want to set updated_at if just saving ind
        flash[:notice] = "Indicator changes saved!"
      end
      redirect_to forms_composite_update_path
    end
  end

  def project_update
    session[:return_to] = request.url
    @user = current_user
    @project = Project.new
    form_id = params[:form_id]
    entry_id = params[:entry_id]
    @current_form = Form.find_by_id(form_id)
    @current_project = Project.find_by_id(entry_id)
    @activities = @current_project.activities
    
    if (request.post? || request.put?)
      if (params[:commit] == "Update Project")
        flash[:notice] = "Project successfully submitted!"
      elsif (params[:commit] == "Save Project")
        flash[:notice] = "Project successfully saved!"
      end
      params[:activity].each do |act|
        #update each activity
      end
      @current_project.update_atributes(params[:project], :updated_at => Time.current)
      redirect_to forms_composite_update_path
    end
  end
  
  def forms_composite
    @user = current_user
    @forms_unchecked = Form.order(sort_column + " " + sort_direction).where(:checked => false, :submitted=>false).find_all_by_user_id(@user.id)
    @forms_saved = Form.order(sort_column + " " + sort_direction).where(:checked => true, :submitted=>false).find_all_by_user_id(@user.id)
  end

  def forms_composite_update
    @user = current_user
    @all_ind_forms = Form.find_all_by_user_id_and_lookup(@user.id, INDICATOR)
    @indicator_forms = []
    @all_ind_forms.each do |form|
      ind = Indicator.find(form.entry_id)
      #make sure month is in freq and we haven't already updated the ind this month
      included = ind.freq.include?(Time.now.month) && (ind.updated_at.month != Time.now.month)
      if (form.submitted && form.checked && form.reviewed && included)
        @indicator_forms << form
      end
    end

     @all_proj_forms = Form.find_all_by_user_id_and_lookup(@user.id, PROJECT)
      @proj_forms = []
      @all_proj_forms.each do |form|
        proj = Project.find(form.entry_id)
        #make sure we haven't already updated the proj this month
        included = proj.updated_at.month != Time.now.month
        if (form.submitted && form.checked && form.reviewed && included)
          @proj_forms << form
        end
      end
  end



  ### THE FOLLOWING ARE JUST HELPER METHODS ###
  private # Note at the top of this file
  
  # Code is taken from:
  # http://railscasts.com/episodes/228-sortable-table-columns
  # modified accordingly
  def sort_column
    Form.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end 
  
  # Code is taken as is from:
  # http://railscasts.com/episodes/228-sortable-table-columns
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
