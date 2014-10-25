require 'sidekiq/web'
Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  resources :posts do 
    resources :comments
  end
  resources :comments
  resources :places do 
    resources :comments
  end
  resources :snowbindings do 
    resources :comments
  end
  resources :snowboots do 
    resources :comments
  end
  resources :videos do 
    resources :comments
  end

  authenticate :user, lambda { |u| u.has_role? :admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  authenticate :user do 
    get 'profile', to: 'users#show'
    get 'modify', to: 'users#edit'
    patch 'modify', to: 'users#update'
  end

  devise_for :users , :controllers => { omniauth_callbacks: "user/omniauth_callbacks" }

  devise_scope :user do
    get "login", to: "user/sessions#new"
    post "login", to: "user/sessions#create"
    delete "logout", to: "user/sessions#destroy"
    get 'signup', to: 'user/registrations#new'
    post 'signup', to: 'user/registrations#create'
  end

  resources :todos do
    member do
      post 'done'
    end
  end

  resources :snowboards do
    member do 
      get 'crawl'
    end
    collection do
      get 'noimage'
    end
  end

  namespace :admin do 
    root to: "home#index"
    resources :settings
    resources :users
    resources :videos
    resources :posts do
      member do
        get 'up'
        get 'recommend'
      end
    end
  end

  root 'welcome#index'

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
