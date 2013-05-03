StrategyStroller::Application.routes.draw do

  ## FOR MAIN PAGE
  ## Move this here, per: https://github.com/gregbell/active_admin/issues/2049
  root :to => "home#index"
  match "home/index" => "home#index", :as => "home_index"  
  get "home/index"

 
  ## FOR ACTIVE ADMIN
  ActiveAdmin.routes(self)


  #get "admin/setup_system" => "admin#setup_system", :as => "asetup_system"

  ## FOR DEVISE
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, :path_names => {:sign_in => 'login', :sign_out => 'logout'}

  ## FOR FORMTASTIC
  resources :user


  ## FOR MAIN PANELS
  

  ## FOR OTHER LINKS / PATHS
  
  # Controller
  match "controller_unit/input_framework/goals" => "controller_unit#set_goal", :as => "goals"
  match "controller_unit/input_framework/indicators" => "controller_unit#set_indicator", :as => "indicators"
  match "controller_unit/input_framework/projects" => "controller_unit#set_project", :as => "projects"
  match "controller_unit/cu_review" => "controller_unit#cu_review", :as => "cu_review"
  match "controller_unit/graph_panel" => "controller_unit#graph_panel", :as => "graph_panel"
  match "controller_unit/goal_check" => "controller_unit#goal_check", :as => 'goal_check'
  match "controller_unit/indicator_check" => "controller_unit#indicator_check", :as => 'indicator_check'
  match "controller_unit/project_check" => "controller_unit#project_check", :as => 'project_check'
  match "controller_unit/all_data" => "controller_unit#all_data", :as => 'all_data'
  match "controller_unit/all_activity" => "controller_unit#all_activity", :as => 'all_activity'
  match "controller_unit/all_project" => "controller_unit#all_project", :as => 'all_project'
  match "controller_unit/all_indicator" => "controller_unit#all_indicator", :as => 'all_indicator'
  match "controller_unit/all_goal" => "controller_unit#all_goal", :as => 'all_goal'
  match "controller_unit/all_dimension" => "controller_unit#all_dimension", :as => 'all_dimension'

  # Provider
  match "provider/goal_define" => "provider#goal_define", :as => 'goal_define'
  match "provider/indicator_define" => "provider#indicator_define", :as => 'indicator_define'
  match "provider/project_define" => "provider#project_define", :as => 'project_define'
  match "provider/activity_define" => "provider#activity_define", :as => 'activities'
  match "provider/indicator_update" => "provider#indicator_update", :as => 'indicator_update'
  match "provider/project_update" => "provider#project_update", :as => 'project_update'
  match "provider/home" => "provider#forms_composite", :as => "forms_composite"
  match "provider/update" => "provider#forms_composite_update", :as => "forms_composite_update"

  #applications path currently defaults to setup_system path so really we only need
  #first 'post' route below, but including all 'post' paths to be safe/in case we need them
  post "controller_unit/setup_system" => "controller_unit#applications", :as => "applications"
  post "controller_unit/create_users" => "controller_unit#applications"
  post "controller_unit/remove_users" => "controller_unit#applications"
  get "controller_unit/setup_system" => "controller_unit#setup_system", :as => "setup_system"
  get "controller_unit/create_users" => "controller_unit#create_users", :as => "create_users"
  get "controller_unit/remove_users" => "controller_unit#remove_users", :as => "remove_users"
  get "controller_unit/edit_users" => "controller_unit#edit_users", :as => "edit_users"

  ### IGNORE RAILS AUTO GENERATED STUFF BELOW ###

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
