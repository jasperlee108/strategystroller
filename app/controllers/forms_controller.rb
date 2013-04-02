class FormsController < ApplicationController
  before_filter :authenticate_user!

  def form_template
    @form = Form.create
    if (request.post?)
        @form = Form.create(params[:form])
        # need to save @form
        # @form has goal, indicator, project info
        # need to save a list of users to send this form to
        #..currently stored in Application table..
        if @form.save
            flash[:notice] = "Form template successfully saved!"
        else
            flash[:error] = "Form template was not saved"
        end
    end
  end
end
