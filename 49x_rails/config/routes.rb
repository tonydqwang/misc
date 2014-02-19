SampleApp::Application.routes.draw do
 
  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  resources :users
  resources :departments
  resources :employees
  resources :allfiles
  resources :timetables
  resources :restrictions
  resources :pools
  resources :jobs
  resources :jobpools
  resources :contracts
  resources :staffs
  
  get '/events/:id', to: 'calendar#show'  

  resources :sessions, only: [:new, :create, :destroy]
  root to: 'static_pages#home'
  
  match '/droid/user', to: 'droids#user',				via: 'post'
  match '/droid/schedule', to: 'droids#schedule',		via: 'post'
  match '/droid/restriction', to: 'droids#restriction',	via: 'post'
  match '/droid/department', to: 'droids#department',	via: 'post'
  match '/droid/pool', to: 'droids#pool',				via: 'post'
  
  match '/signup', to: 'users#new',             via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  
  match '/help', to: 'static_pages#help'
  match '/about', to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/manageSchedule', to: 'static_pages#manageSchedule'
  
  match '/createdept', to: 'departments#new',   via: 'get'
  match '/createdept', to: 'departments#new',   via: 'post'
  match '/joindept', to: 'employees#new',   via: 'get'
  match '/finddept', to: 'employees#find',   via: 'get'
  match '/createschedule', to: 'allfiles#new',  via: 'get'
  match '/generateschedule', to: 'allfiles#show',  via: 'get'
  match '/indivschedule', to: 'calendar#show',  via: 'get'
  
  #match '/schedule', to: 'timetables#index',  via: 'get'
  match '/schedule', to: 'calendar#index',  via: 'get'
  
  match '/restriction', to: 'restrictions#show',  via: 'get'
  match '/newrestriction', to: 'restrictions#new',  via: 'get'
  
  match '/showcontract', to: 'contracts#show',  via: 'get'
  match '/newcontract', to: 'contracts#new',  via: 'get'
  
  match '/showpool', to: 'pools#show',  via: 'get'
  match '/newpool', to: 'pools#new',  via: 'get'
  
  match '/showjobpool', to: 'jobpools#show',  via: 'get'
  match '/newjobpool', to: 'jobpools#new',  via: 'get'
  
  match '/showjob', to: 'jobs#show',  via: 'get'
  match '/newjob', to: 'jobs#new',  via: 'get'
  
  match '/showstaff', to: 'staffs#show',  via: 'get'
  match '/newstaff', to: 'staffs#new',  via: 'get'
  
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
