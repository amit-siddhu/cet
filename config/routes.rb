Cet::Application.routes.draw do
  resources :users do
    collection { post :import }  
  end
resources :confirm_users

get "users/index"

get "users/signup"

get "users/registration"

get "users/dashboard"

get "confirm_users/confirm_users"

get "users/password_reset"

post "users/passreset"

get "users/logout"

get "users/create_tsp"

get "users/create_circle"

get "users/create_cne"

get "users/create_ane"

get "users/add_emission"

post "users/tsp_created"

post "users/circle_created"

post "users/cne_created"

post "users/ane_created"

post "users/add_emission"

get "users/generate_report"

get "users/calculate_emission"

get "users/cne_by_circle"


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
   root :to => 'users#index'
match '/signup',    to: 'users#signup'
match '/registration',    to: 'users#registration'
match '/dashboard',    to: 'users#dashboard'
match '/password_reset',    to: 'users#password_reset'
match '/passreset',    to: 'users#passreset'
match '/logout',    to: 'users#logout'
match '/create_tsp',    to: 'users#create_tsp'
match '/create_circle',    to: 'users#create_circle'
match '/create_cne',    to: 'users#create_cne'
match '/create_ane',    to: 'users#create_ane'
match '/add_emission',    to: 'users#add_emission'
match '/tsp_created',    to: 'users#tsp_created'
match '/circle_created',    to: 'users#circle_created'
match '/cne_created',    to: 'users#cne_created'
match '/ane_created',    to: 'users#ane_created'
match '/emission_added',    to: 'users#emission_added'
match '/generate_report',    to: 'users#generate_report'
match '/calculate_emission',    to: 'users#calculate_emission'

match '/cne_by_circle',    to: 'users#cne_by_circle'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
