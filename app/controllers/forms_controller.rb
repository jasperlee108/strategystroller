class FormsController < ApplicationController
  before_filter :authenticate_user!

  def form_template
    @form = Form.new
    if (request.post?)
        @form = Form.new(params[:form])
        if @form.save
            #Once we connect the mailing service, make sure form is saved and SENT to those specified
            flash[:notice] = "Form template successfully saved!"
        else
            flash[:error] = "Form template and users not saved"
            return
        end

        users = params[:users]
        count = 0
        total = 0
        if (users)
            users.each do |info|
                total += 1
                user = User.new(info)
                if !user.save
                    count+= 1
                end
            end
        end
        
        if (count != total)
            # May end up wanting to specify which users not saved/sent to
            flash[:error] = count + " users not saved"
        else
            flash[:notice] = "All users successfully saved!"
        end

    end
  end
end
