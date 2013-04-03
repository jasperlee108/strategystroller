class FormsController < ApplicationController
  before_filter :authenticate_user!

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


end
