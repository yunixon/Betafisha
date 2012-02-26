Betafisha::Application.routes.draw do

  devise_for :users
  resources :users
  resources :posts
  resources :topics
  resources :forums
  resources :events
  resources :coupons
  resources :news_blocks
  resources :news_posts
  resources :page_subjects


  resources :sports
  resources :countries
  resources :leagues
  resources :participants


  # nav
  get "site_top_navigation/coefficients"
  match "coefficients" =>  "site_top_navigation#coefficients", :as => :coefficients
  get "site_top_navigation/bookmakers"
  match "bookmakers"  =>  "site_top_navigation#bookmakers", :as => :bookmakers
  get "site_top_navigation/statistics"
  match "statistics" =>  "site_top_navigation#statistics", :as => :statistics
  get "site_top_navigation/tools"
  match "tools" =>  "site_top_navigation#tools", :as => :tools

 # add coupon
  match "leaguetocoupon", :to =>  "leagues#leaguetocoupon", :as => :leaguetocoupon

  # admin
  get "admin/users_manager"
  match "admin" =>  "admin#users_manager", :as => :admin

  get "admin/leagues_manager"
  match "admin/leagues_manager" =>  "admin#leagues_manager", :as => :leagues_manager

  get "admin/users_manager"
  match "admin/users_manager" =>  "admin#users_manager", :as => :users_manager

  get "admin/pages_manager"
  match "admin/pages_manager" =>  "admin#pages_manager", :as => :pages_manager

  get "admin/news_manager"
  match "admin/news_manager" =>  "admin#news_manager", :as => :news_manager

  get "admin/bookmakers_manager"
  match "admin/bookmakers_manager" =>  "admin#bookmakers_manager", :as => :bookmakers_manager

  get "admin/add_bookmaker_relation"
  match "admin/add_bookmaker_relation" =>  "admin#add_bookmaker_relation", :as => :add_bookmaker_relation

  get "admin/delete_bookmaker_relation"
  match "admin/delete_bookmaker_relation" =>  "admin#delete_bookmaker_relation", :as => :add_bookmaker_relation

  get "admin/cache_expire"
  match "admin" =>  "admin#cache_expire", :as => :cache_expire

  post "admin/league_edit"
  post "admin/league_new"

  post "admin/sport_edit"
  post "admin/sport_new"

  post "admin/country_edit"
  post "admin/country_new"

  #devise





  # statc (flat) pages
  resources :pages
  match '/info/:permalink' => "pages#show"

  # root page
  root :to => "site_top_navigation#coefficients"

end

