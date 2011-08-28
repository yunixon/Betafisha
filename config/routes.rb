Betafisha::Application.routes.draw do 

  # user auth & reg
  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  resources :password_resets
  
  resources :sports
  resources :countries
  resources :ligues
  resources :teams
  
  match "signup" => "users#new", :as => :signup
  match "users" => "users#index", :as => :users 
  match "signin" => "sessions#new", :as => :signin
  match "signout" => "sessions#destroy", :as => :signout 

  # nav
  get "site_top_navigation/coefficients"
 # match "coefficients" =>  "site_top_navigation#coefficients", :as => :coefficients
 get "site_top_navigation/bookmakers"
 # match "bookmakers"  =>  "site_top_navigation#bookmakers", :as => :bookmakers
  get "site_top_navigation/statistics"
 # match "statistics" =>  "site_top_navigation#statistics", :as => :statistics
  get "site_top_navigation/tools"
 # match "tools" =>  "site_top_navigation#tools", :as => :tools

 # test page for feeds
  match "/api_test", :to =>  "bets_loader#api_test", :as => :api_test 
   
 
  # admin
  get "admin/index"
  match "admin" =>  "admin#index", :as => :admin
  
  get "admin/sports_manager"
  match "admin/sports_manager" =>  "admin#sports_manager", :as => :sports_manager
  
  get "admin/users_manager"
  match "admin/users_manager" =>  "admin#users_manager", :as => :users_manager
  
  post "admin/ligue_edit"
  post "admin/ligue_new"   
  
  post "admin/sport_edit"
  post "admin/sport_new"
  
  post "admin/country_edit"
  post "admin/country_new"
  
  # statc (flat) pages
  resources :pages
  match '/:permalink' => "pages#show"
   
  # root page
  root :to => "stub#stub"


end
