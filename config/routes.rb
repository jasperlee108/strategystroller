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
  match "provider/provider_panel" => 'provider#provider_panel', :as => 'provider_panel'

  ## FOR OTHER LINKS / PATHS
  match "controller_unit/input_framework" => "controller_unit#set_goal", :as => 'input_framework'
  match "controller_unit/input_framework/goals" => "controller_unit#set_goal", :as => "goals"
  match "controller_unit/input_framework/indicators" => "controller_unit#set_indicator", :as => "indicators"
  match "controller_unit/input_framework/projects" => "controller_unit#set_project", :as => "projects"
  match "controller_unit/input_framework/activities" => "controller_unit#set_activity", :as => "activities"

  match "controller_unit/cu_review" => "controller_unit#cu_review", :as => "cu_review"

  #applications path currently defaults to setup_system path so really we only need
  #first 'post' route below, but including all 'post' paths to be safe/in case we need them
  post "controller_unit/setup_system" => "controller_unit#applications", :as => "applications"
  post "controller_unit/create_users" => "controller_unit#applications"
  post "controller_unit/remove_users" => "controller_unit#applications"

  get "controller_unit/setup_system" => "controller_unit#setup_system", :as => "setup_system"
  get "controller_unit/create_users" => "controller_unit#create_users", :as => "create_users"
  get "controller_unit/remove_users" => "controller_unit#remove_users", :as => "remove_users"

  match "provider/unchecked" => "provider#unchecked", :as => "unchecked"
  match "provider/saved" => "provider#saved", :as => "saved"
  
  ## FOR MAIN PAGE
  root :to => redirect("/controller_unit/welcome")
  match "controller_unit/welcome" => 'controller_unit#welcome', :as => 'controller_unit_welcome'
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
