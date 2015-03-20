Gemabapp::Application.routes.draw do
 
  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :subscriptions

  get "payment/confirm"

  ActiveAdmin.routes(self)

  

  #
  resources :bmi

  require 'subdomain'
  
  resources :groups, :only => [:index, :show]
  namespace :my do
    resources :groups
    resource :group_members, :only => [:create, :destroy]
    resources :group_comments, :only => [:create]
    resources :bmi
    resources :users, :only => [:update]
    resources :private_messages
    resources :conversations
    resources :suggestions, :only => [:index, :create, :show] do
      resources :votings, :only => [:index, :create, :update]
    end
    resource :account # :profile before
    match '/profil' => 'users#show', :as => 'userprofile'
    resources :targets
    match 'targets/archive' => 'targets#destroy', :as => :archive_target
    resources :weights
    resource :setting
    resources :supporters #, :only => [:index, :show]
    post 'supporter/confirm' => 'supporters#confirm'
    resources :payments, :only => [:new, :show]
    resources :tickers, :only => [:show]
    resources :charts, :only => [:show]
  end
  
  namespace :all do
    resources :groups, :only => [:index, :show]
    resources :supporters do
      resources :groups, :only => [:index]
      resources :supporters, :only => [:index]
    end
  end

  
  get "landingpages/index"
  match '/landingpages/winterspeck-weg' => "landingpages#winterspeck_weg"

  get "pages/index"

  devise_for :users, :path => '', :path_names => {
    :sign_in => 'login',
    :sign_out => 'logout',
    :password => 'password',
    :confirmation => 'verification',
    :unlock => 'unblock',
    :registration => 'register'    
  }

#  resource :supporter
#  post 'supporter/confirm' => 'supporters#confirm'
#  resources :supporters, :only => [:index, :show]

  

  
  
 

  resources :pinboard_messages


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
  #
  #match '/accounts' => "supporters#index"
  resources :accounts, :only => [:index, :show]

  match '/tour/gewichtstagebuch' => 'pages#gewichtstagebuch', :as => 'gewichtstagebuch'
  match '/tour/unterstuetzer' => 'pages#unterstuetzer', :as => 'unterstuetzer'
  match '/tour/ziele' => 'pages#ziele', :as => 'ziele'
  match '/tour/profil' => 'pages#profil', :as => 'profil'
  match '/tour' => 'pages#tour', :as => 'tour'  
  match '/sitemap.:format' => 'sitemap#show', :as => 'sitemap'
  match '/users/current.:format' => 'users#show' #only needed for js
  match '/datenschutz' => "pages#datenschutz"
  match '/impressum' => "pages#impressum"
  match '/nutzungsbedingungen' => "pages#nutzungsbedingungen"
  match '/blog' => "pages#blog"
  match '/macher' => "pages#macher"

  match '/tipps/schnell-und-gesund-abnehmen' => 'tips#schnell_und_gesund_abnehmen', :as => 'tipps_schnell_und_gesund_abnehmen'
  match '/tipps/tipps-der-community-zum-abnehmen' => 'tips#mitglieder_tipps', :as => 'mitglieder_tipps'

  match '/ticker' => "ticker#index"

  constraints(Subdomain) do
    #match '/' => "users#show" #now using /accounts/:id
    #match '/profil' => 'users#profile', :as => 'userprofile' #moved to namespace "my"
    match '/profil_new' => 'users#profile_new', :as => 'userprofilenew'
  end

  root :to => "pages#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
