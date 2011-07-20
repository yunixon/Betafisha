Oddschecker::Application.routes.draw do

  get "bets_loader/index"
  
  match "/api_test", :to =>  "bets_loader#api_test", :as => :api_test
  #resources :users
  
  #scope "/:locale" do
  resources :users
  #end
  
  get "users/new"
  match '/signup', :to => 'users#new', :as => :singup

   get "site_top_navigation/coefficients"
   match "/coefficients", :to =>  "site_top_navigation#coefficients", :as => :coefficients
   get "site_top_navigation/bookmakers"
   match "/bookmakers" , :to =>  "site_top_navigation#bookmakers", :as => :bookmakers
   get "site_top_navigation/statistics"
   match "/statistics" , :to =>  "site_top_navigation#statistics", :as => :statistics
   get "site_top_navigation/tools"
   match "/tools" , :to =>  "site_top_navigation#tools", :as => :tools
  # get "site_top_navigation/gaming"
   # match "/gaming" , :to =>  "site_top_navigation#gaming", :as => :gaming
  # get "site_top_navigation/news"
  # match "/news" , :to =>  "site_top_navigation#news", :as => :news

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
  root :to => "site_top_navigation#coefficients"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
