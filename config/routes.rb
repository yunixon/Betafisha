Betafisha::Application.routes.draw do 

  resources :coupons

  resources :comments

  resources :news_blocks
  resources :news_posts
  resources :page_subjects

  # user auth & reg
  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  resources :password_resets
  
  resources :sports
  resources :countries
  resources :leagues
  resources :participants
  
  match "signup" => "users#new", :as => :signup
  match "users" => "users#index", :as => :users 
  match "signin" => "sessions#new", :as => :signin
  match "signout" => "sessions#destroy", :as => :signout 

  # nav
  get "site_top_navigation/coefficients"
  match "coefficients" =>  "site_top_navigation#coefficients", :as => :coefficients
  get "site_top_navigation/bookmakers"
  match "bookmakers"  =>  "site_top_navigation#bookmakers", :as => :bookmakers
  get "site_top_navigation/statistics"
  match "statistics" =>  "site_top_navigation#statistics", :as => :statistics
  get "site_top_navigation/tools"
  match "tools" =>  "site_top_navigation#tools", :as => :tools

 # test page for feeds
  match "/api_test", :to =>  "bets_loader#api_test", :as => :api_test 
   
 
  # admin
  get "admin/index"
  match "admin" =>  "admin#index", :as => :admin
  
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
  
  post "admin/league_edit"
  post "admin/league_new"   
  
  post "admin/sport_edit"
  post "admin/sport_new"
  
  post "admin/country_edit"
  post "admin/country_new"
  
  # statc (flat) pages
  resources :pages
  match '/info/:permalink' => "pages#show"
   
  # root page
  root :to => "site_top_navigation#coefficients"
  
end
