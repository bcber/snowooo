require 'sidekiq/web'
Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  mount Ckeditor::Engine => '/ckeditor'

  resources :places ,:snowboards , :snowbindings ,:snowboots ,:videos,:comments do
    resources :comments
  end
  get "videos/node/:node_id" => "videos#node" ,as: :videos_node
  get "places/region/:region" => "places#region", as: :places_region
  get "posts/node/:node_id" => "posts#node",as: :posts_node

  resources :likes

  resources :comments do
    member do
      get 'new_reply'
      post 'reply'
    end
  end

  resources :posts do
    resources :comments
    collection do
      get 'category/:category' => 'posts#category', as: :category
    end
  end

  authenticate :user, lambda { |u| u.has_role? :admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get 'u/:id' => 'users#show', as: :user
  authenticate :user do
    get 'notification', to: 'notifications#show', as: :notification
    get 'notification/read/:id', to:'notifications#read', as: :read_notification
    get 'notification/unread/:id', to:'notifications#unread', as: :unread_notification
    get 'notification/history', to:'notifications#history',as: :history_notification
    get 'check_in', to: 'users#check_in', as: :check_in
    get 'profile', to: 'users#profile'
    get 'modify', to: 'users#edit'
    patch 'modify', to: 'users#update'
  end

  devise_for :users , :controllers => {
      sessions: "user/sessions",
      passwords: "user/passwords",
      registrations: "user/registrations",
      unlocks:"user/unlocks",
      omniauth_callbacks: "user/omniauth_callbacks"
  }

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

  get 'bbs/topics/new' => 'bbs/topics#new', as: :new_bbs_topic
  get 'bbs/topics/hot' => 'bbs/topics#hot', as: :hot_bbs_topics
  get 'bbs/topics/no_comment' => 'bbs/topics#no_comment',as: :no_comment_bbs_topics
  get 'bbs/topics/good' => 'bbs/topics#good', as: :good_bbs_topics
  get 'bbs/topics/node/:node_id' => 'bbs/topics#node', as: :bbs_topics_node
  get 'bbs/topics/:id' => 'bbs/topics#show',as: :topic

  namespace :bbs do
    root to: "home#index"
    resources :topics do
      resources :comments, controller: "/comments"
    end
    resources :topic_nodes
  end

  namespace :admin do 
    root to: "home#index"
    resources :topics
    resources :video_nodes
    resources :topic_nodes
    resources :settings
    resources :users
    resources :post_nodes
    resources :posts , :places, :videos, :snowboots, :snowbindings , :snowboards do
      member do
        get 'up'
        get 'recommend'
        get 'down'
      end
    end

    resources :posts do
      member do
        get 'pass'
      end
    end
  end

  root 'welcome#index'
  get 'gear' => 'gear#snowboard'
  get 'gear/snowboard' => 'gear#snowboard'
  get 'gear/snowboot' => 'gear#snowboot'
  get 'gear/snowbinding' => 'gear#snowbinding'

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
