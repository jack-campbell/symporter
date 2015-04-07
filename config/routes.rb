Rails.application.routes.draw do
  get 'sessions/new'

  get 'us/new'

  get 'static_pages/login2'

  get 'users/new'

  get 'static_pages/home'

  get 'static_pages/about'

  get 'static_pages/market'

  get 'static_pages/forum'

  get 'static_pages/contact'

  get 'static_pages/login'
    
  root 'static_pages#home'
  
   get '/about' => 'static_pages#about'
get '/contact' => 'static_pages#contact'
  get '/market' => 'static_pages#market'
get '/forum' => 'static_pages#forum'
  get '/login' => 'us#new'
  get '/login2' => 'static_pages#login2'
  
  
  resources  :us
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
