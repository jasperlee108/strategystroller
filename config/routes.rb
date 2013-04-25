StrategyStroller::Application.routes.draw do
  
  get "home/index"

  ## FOR ACTIVE ADMIN
  ActiveAdmin.routes(self)

  ## FOR DEVISE
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, :path_names => {:sign_in => 'login', :sign_out => 'logout'}

  ## FOR FORMTASTIC
  resources :user

  ## FOR MAIN PANELS
  match "admin/admin_panel" => 'admin#admin_panel', :as => 'admin_panel'
  match "controller_unit/controller_panel" => 'controller_unit#controller_panel', :as => 'controller_panel'
  #match "provider/provider_panel" => 'provider#provider_panel', :as => 'provider_panel'
  #match "provider/provider_panel/define" => 'provider#define_page', :as => 'provider_panel_define'
  #match "provider/provider_panel/update" => 'provider#update_page', :as => 'provider_panel_update'

  ## FOR OTHER LINKS / PATHS
  
  # Controller
  match "controller_unit/input_framework/activities" => "controller_unit#set_activity", :as => "activities"
  match "controller_unit/input_framework" => "controller_unit#goals_list", :as => "input_framework"
  match "controller_unit/input_framework/goals_list" => "controller_unit#goals_list", :as => "goals_list"
  match "controller_unit/input_framework/indicators_list" => "controller_unit#indicators_list", :as => "indicators_list"
  match "controller_unit/input_framework/projects_list" => "controller_unit#projects_list", :as => "projects_list"
  match "controller_unit/input_framework/goals" => "controller_unit#set_goal", :as => "goals"
  match "controller_unit/input_framework/indicators" => "controller_unit#set_indicator", :as => "indicators"
  match "controller_unit/input_framework/projects" => "controller_unit#set_project", :as => "projects"
  match "controller_unit/cu_review" => "controller_unit#cu_review", :as => "cu_review"
  match "controller_unit/graph_panel" => "controller_unit#graph_panel", :as => "graph_panel"
  match "controller_unit/activity_list" => "controller_unit#activity_list", :as => "activity_list"
  match "controller_unit/view_activity" => "controller_unit#view_activity", :as => "activity"  
  #match "controller_unit/saved" => "controller_unit#saved", :as => "saved"
  match "controller_unit/goal_check" => "controller_unit#goal_check", :as => 'goal_check'
  match "controller_unit/indicator_check" => "controller_unit#indicator_check", :as => 'indicator_check'
  match "controller_unit/project_check" => "controller_unit#project_check", :as => 'project_check'
  match "controller_unit/activity_check" => "controller_unit#activity_check", :as => 'activity_check'
  #match "controller_unit/indicator_update" => "controller_unit#indicator_update", :as => 'indicator_update'
  #match "controller_unit/project_update" => "controller_unit#project_update", :as => 'project_update'

  # Provider
  match "provider/unchecked" => "provider#unchecked", :as => "unchecked"
  match "provider/saved" => "provider#saved", :as => "saved"
  match "provider/goal_define" => "provider#goal_define", :as => 'goal_define'
  match "provider/indicator_define" => "provider#indicator_define", :as => 'indicator_define'
  match "provider/project_define" => "provider#project_define", :as => 'project_define'
  match "provider/activity_define" => "provider#activity_define", :as => 'activities'
  match "provider/indicator_update" => "provider#indicator_update", :as => 'indicator_update'
  match "provider/project_update" => "provider#project_update", :as => 'project_update'
  match "provider/home" => "provider#forms_composite", :as => "forms_composite"

  #applications path currently defaults to setup_system path so really we only need
  #first 'post' route below, but including all 'post' paths to be safe/in case we need them
  post "controller_unit/setup_system" => "controller_unit#applications", :as => "applications"
  post "controller_unit/create_users" => "controller_unit#applications"
  post "controller_unit/remove_users" => "controller_unit#applications"
  get "controller_unit/setup_system" => "controller_unit#setup_system", :as => "setup_system"
  get "controller_unit/create_users" => "controller_unit#create_users", :as => "create_users"
  get "controller_unit/remove_users" => "controller_unit#remove_users", :as => "remove_users"
  
  ## FOR MAIN PAGE
  root :to => "home#index"
  match "home/index" => "home#index", :as => "home_index"

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
