ActiveAdmin.register Application do 
menu :priority => 1, :label =>  "Settings"

config.clear_action_items!
controller do
	def index
        if Application.find(1)
            redirect_to "/admin/applications/1/edit"
        end
	end

end

form do |f|                         
    f.inputs "Admin Details" do       
		f.input :company
		f.input :curr_year, :label => "Current Year", :as => :select, :collection => Application::YEARS, :prompt => true
		f.input :init_year, :label => "Initial Year", :as => :select, :collection =>  Application::YEARS, :prompt => true
		f.input :language, :as => :select, :collection =>  Application::LANGUAGES, :prompt => true
		f.input :time_horizon, :as => :select, :collection =>  Application::TIME_HORIZON, :prompt => true
    end                               
    f.actions                         
  end       
  


end                                   
