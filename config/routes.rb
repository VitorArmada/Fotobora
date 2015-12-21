Fotobora::Application.routes.draw do

  resources :votetypes

  resources :requests

  root 'users#show'

  get 'search', to: 'search#index', as: :search

  # shallow do
  #   resources :photos do
  #     resources :photostories
  #     resources :entities do
  #       resources :entitystories
  #     end
  #   end
  # end

  shallow do
    resources :photos , except: [:index] do
      resources :photostories, except: [:index]
      resources :entities, only: [:new, :create, :show, :destroy] do
        resources :entitystories, except: [:index]
      end
    end
  end

  resources :photos do
    member do
      get 'print'
      get 'import'
      post 'import_post'
    end
  end

   resources :entities do
    member do
      patch 'add_entity_type'
    end
  end


  resources :photostorycomments, except: [:index]

  resources :entitystorycomments, except: [:index]
  
  resources :properties, except: [:index]

  resources :votes, except: [:index]

  devise_for :users

  #get 'users(/:id)' => 'users#show', as: :user
  
  resources :users, except: [:new, :create, :edit, :update, :destroy, :index] do
    member do
      get 'show'
      get 'import'
      post 'import_post'
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'welcome#index'

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
