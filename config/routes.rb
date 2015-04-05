Rails.application.routes.draw do

  get 'users/show'

  resources :collections

  #resources :players

  resources :plays do
    resources :comments do
      get 'report', :on => :member
    end
  end

  resources :games

  devise_for :users,
             controllers: {omniauth_callbacks: "omniauth_callbacks"}
  match 'users/:id' => 'users#show', as: :user, via: :get
  match 'users/:id/compare/:game_id' => 'users#compare', as: :compare, via: :get


  authenticated :user do
    root :to => 'users#root', as: :authenticated_root
    #root :to => 'pages#main', as: :authenticated_root
  end
  root :to => 'pages#home'


  get 'main' => "pages#main", as: :main
  get 'blog' => "pages#blog", as: :blog

  resources :bgg_search_suggestions

  resources :autofill do
    get 'bgg', :on => :collection
    get 'location', :on => :collection
    get 'player', :on => :collection
    get 'game', :on => :collection
  end

  resources :friends, :controller => 'friendships', :except => [:show, :edit, :new] do
    put "block", :on => :member
    put "unblock", :on => :member
  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
