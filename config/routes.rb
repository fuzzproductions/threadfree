ActionController::Routing::Routes.draw do |map|
  map.resources :pages

  map.resources :comments

  map.resources :users

  map.resources :designs

  map.root :controller => 'home'
  
  map.create_user 'login/create_user', :controller => 'login', :action => 'create_user'
  
  map.login 'login/login', :controller => 'login', :action => 'login'
  
  map.logout 'login/logout', :controller => 'login', :action =>'logout'
  
  map.upload 'manage_designs/upload', :controller => 'manage_designs', :action => 'upload'
  
  map.manage_designs 'manage_designs', :controller => 'manage_designs', :action => 'index'
  
  map.rate 'designs', :controller => 'designs', :action => 'index'
  
  map.view_designs 'designs/show/:id', :controller => 'designs', :action => 'show'
  
  map.download_design 'manage_designs/download_design', :controller => 'manage_designs', :action => 'download_design'
  
  map.show_page 'pages/show/:id', :controller => 'pages', :action => 'show'
  
  map.update_profile 'login/update_profile', :controller => 'login', :action => 'update_profile'
  
  map.profile 'users/show/:id', :controller => 'users', :action => 'show'
  
  map.change_password 'login/change_password', :controller => 'login', :action => 'change_password'
  
  map.change_profile_picture 'login/change_profile_picture', :controller => 'login', :action => 'change_profile_picture'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
