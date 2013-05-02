ActiveAdmin.register_page "Settings" do

  menu false
controller do

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
end


    # Here is an example of a simple dashboard with columns and panels.
    # menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") } (goes at top)
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  #end # content
end
