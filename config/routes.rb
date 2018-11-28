Rails.application.routes.draw do

  get 'sponsorship' => 'home#sponsorship'
  get 'membership' => 'home#membership'
  get 'giftpolicy' => 'home#giftpolicy'
  get 'update-subscription' => 'home#update_subscription'

  namespace :admin do
    resources :donation_roll_ups, :except => [:new, :create, :edit, :update, :destroy] do
      collection do
        get :csv, :as => :csv
      end
    end
    resources :donations, :except => [:edit,:update,:delete] do
      collection do
        get :choose, :as => :choose
        get :csv, :as => :csv
      end
    end
    resources :subscriptions, :except => [:edit,:update,:new,:create]
  end
  resources :donations, :except => [:edit,:update,:destroy]
  resources :subscriptions, :except => [:edit,:update]
  resources :coupons, :only => [:show, :destroy]
  root 'home#index'

  mount StripeEvent::Engine, at: "/stripe_webhooks"

  require 'sidekiq/web'
  constraints lambda {|request| AuthConstraint.admin?(request) } do
    mount Sidekiq::Web => '/admin/sidekiq'
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
