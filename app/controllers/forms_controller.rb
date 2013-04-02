class FormsController < ApplicationController
  before_filter :authenticate_user!

  def form_template
    @form = Form.create
    if (request.post?)
        @form = Form.create(params[:form])
        if @form.save
            flash[:notice] = "Form template successfully saved!"
        else
            flash[:error] = "Form template was not saved"
            return
        end

        users = params[:users]
        count = 0
        total = 0
        users.each do |info|
            total += 1
            user = User.new(info)
            if !user.save
                count+= 1
            end
        end
        
        if (count != total)
            flash[:error] = count + " users not saved"
        else
            flash[:notice] = "All users successfully saved!"
        end

    end
  end
end
