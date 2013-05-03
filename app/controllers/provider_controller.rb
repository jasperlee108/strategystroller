class ProviderController < ApplicationController
  before_filter :authenticate_user!
  
  MAILER = ActionMailer::Base.default_url_options

 # def encode_url(form_id)
  #  encoded_id = encode_id(form_id.to_s)
   # url = "http://localhost:3000/forms?form_id=" + encoded_id.to_s #TEMP
  #end
   
  def goal_define
    @user = current_user
    @goal = Goal.new
    form_id = params[:form_id]
    entry_id = params[:entry_id]
    @current_form = Form.find_by_id(form_id)
    @current_goal = Goal.find_by_id(entry_id)
    @current_form.update_attributes(:checked => true)
    if (request.post?)
      if (params[:commit] == "Submit Goal")
        @current_form.update_attributes(:submitted => true)
        flash[:notice] = "Goal successfully submitted!"
      elsif (params[:commit] == "Save Goal")
        flash[:notice] = "Goal successfully saved!"
      end
      @current_goal.update_attributes(params[:goal])
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
    @current_form.update_attributes(:checked => true)
    @goal_short_names = (Goal.select('short_name')).collect{|g| g.short_name}
    if (request.post?)
      #read workingBranch's indicator.freq implementation
      #^ has not been merged in yet
      #the indicator's freq field is an Array
      #:freq is going to be a String
      #:special_freq is going to be an Array[String]
      # freq is going to be an Array[String]
      freq = []
      freqStr = params[:indicator][:freq]
      freqArr = params[:indicator][:special_freq]
      if (freqStr == "S")
        freqArr.each do |month|
          if (month != "")
            freq << month.to_i
          end
        end
      elsif (freqStr == "M")
        freq.push(1,2,3,4,5,6,7,8,9,10,11,12)
      elsif (freqStr == "Q") #double check this?
        freq.push(1,4,7,10)
      elsif (freqStr == "HY")
        freq.push(1,7)
      elsif (freqStr == "Y")
        freq.push(1)
      elsif (freqArr == [""])
        freq = []
      else #this case should never be reached
        flash[:error] = "Wrong frequency type selected"
      end
      params[:indicator].delete(:special_freq)
      params[:indicator][:freq] = freq


      if (!(@current_indicator.update_attributes(params[:indicator]))) #fields unsuccessfully updated
        Rails.logger.info(@current_indicator.errors.messages.inspect)
        flash[:error] = "An error occurred in submitting the form, please try again."
      elsif (params[:commit] == "Submit Indicator")
        @current_form.update_attributes(:submitted => true)
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
    @current_form.update_attributes(:checked => true)
    @activities = @current_project.activities
    if (request.post?)
      if (params[:commit] == "Submit Project")
        @current_form.update_attributes(:submitted => true)
        flash[:notice] = "Project successfully submitted!"
      elsif (params[:commit] == "Save Project")
        flash[:notice] = "Project successfully saved!"
      end
      @current_project.update_attributes(params[:project])
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
      if @activity.save # activity saved
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
    @current_form.update_attributes(:checked => true)
    @goal_short_names = (Goal.select('short_name')).collect{|g| g.short_name}
    if (request.post?)
      if (params[:commit] == "Submit Indicator")
        @current_form.update_attributes(:submitted => true)
        flash[:notice] = "Indicator successfully submitted!"
      elsif (params[:commit] == "Save Indicator")
        flash[:notice] = "Indicator successfully saved!"
      end
      @current_indicator.update_attributes(params[:indicator])
      redirect_to forms_composite_path
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
    @current_form.update_attributes(:checked => true)
    @activities = @current_project.activities
    if (request.post?)
      if (params[:commit] == "Submit Project")
        @current_form.update_attributes(:submitted => true)
        flash[:notice] = "Project successfully submitted!"
      elsif (params[:commit] == "Save Project")
        flash[:notice] = "Project successfully saved!"
      end
      @current_project.update_attributes(params[:project])
      redirect_to forms_composite_path
    end
  end
  
  def forms_composite
    @user = current_user
    @forms_unchecked = Form.where(:checked => false, :submitted=>false).find_all_by_user_id(@user.id)
    @forms_saved = Form.where(:checked => true, :submitted=>false).find_all_by_user_id(@user.id)
  end
  
  
end
