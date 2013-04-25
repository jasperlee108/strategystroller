class FormsController < ApplicationController
  before_filter :authenticate_user!

  ## INFO
  GOAL = 1
  INDICATOR = 2
  PROJECT = 3
  ACTIVITY = 4

  def form_template
    @form = Form.new
    if (request.post?)
        # Check if this particular goal/ind/proj-combo form already exists
        form_hash = params[:form]
        goal_id = form_hash[:goal_id]
        indicator_id = form_hash[:indicator_id]
        project_id = form_hash[:project_id]
        if (!(goal_id && indicator_id && project_id))
            # Just return if all fields aren't filled out
            flash[:error] = "All required fields must be filled out"
            return
        else
            @form = Form.find_by_goal_id_and_indicator_id_and_project_id(goal_id, indicator_id, project_id)

            if (@form)
                form_id = @form[:id]
                # Associate providers with this form
                 user_ids = form_hash[:user_ids]
                 user_ids.shift
                @form.users << User.find(user_ids)

               # form_hash[:user_ids].each do |id|
                 #   Form.create(:form_id => form_id, :user_id => id)
                    # Will do nothing if user already associated with this form
                #end
                flash[:notice] = "Old form template successfully updated!"
            else
                # this form doesn't exist yet so:
                @form = Form.new(:goal_id => goal_id, :indicator_id => indicator_id, :project_id => project_id)
                if @form.save
                    form_id = @form[:id]
                    #Once we connect the mailing service, make sure form is SENT to those specified
                    # Associate providers with this form
                    user_ids = form_hash[:user_ids]
                 user_ids.shift
                @form.users << User.find(user_ids)
                    #form_hash[:user_ids].each do |id|
                     #   Form.create(:form_id => form_id, :user_id => id)
                        # Will do nothing if user already associated with this form
                   # end
                    flash[:notice] = "New form template successfully saved!"

                else
                    flash[:error] = "New form template not saved"
                    return
                end
            end

        end
    end
  end

  def render_forms
        #url.com/forms?form_id=x
        #match "/forms" => "forms#render_forms"
      #have a /forms route that based on what form table_id is,
      #gets the field info from appropriate table and
      #loads /controller_unit/setup_x
      #and prepopulates some fields based on the status of the form
      form_id = params[:form_id]
        form_id = ControllerUnitController.decode_id(form_id)
        form = Form.find_by_id(form_id)
    if (request.get?) #want to load page with populated fields
        lookup = form.lookup
        

        if (form.submitted && @current_user.controlling_unit) #CU wants to pull up submitted goal form
            #id and associated indicators should be readonly
            render "/controller_unit/setup_goal"
        elsif (!form.submitted && !form.reviewed && !@current_user.controlling_unit) #Provider wants to access form, however many times
            #id, full name, short name, dimension, owner, department readonly
            #what if provider has to redo form?
        else
            #unauth access
        end


        if (lookup == GOAL)
        elsif (lookup == INDICATOR)
        elsif (lookup == PROJECT)
            render "/controller_unit/setup_project"
        elsif (lookup == ACTIVITY)
            render "/controller_unit/setup_activity"
        end


    else #post request, want to submit form info
        

    end
  end


end
