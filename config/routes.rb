Rails.application.routes.draw do
  get 'sessions/new'

  resources :events
  root :to => redirect('/events')
  get '/search', to: 'events#search'
  get '/upload', to: 'events#upload'
  
  get '/register', to: 'users#new'
  resources :users, only: [:create, :show]

  get '/sign_in', to: 'sessions#new'
  get '/sign_out', to: 'sessions#destroy'
  resource :sessions, only: [:create]

  #upload
  get '/upload_new_local_file', to: 'uploads#new_local'
  post '/upload_local_file', to: 'uploads#upload_local'
  
  resources :files, only: %i[index show destroy]
  post '/store_file/:id', to: 'files#store', as: 'store_file'
  post '/copy_file/:id', to: 'files#copy', as: 'copy_file'
  get '/new_store_file_batch', to: 'files#new_store_file_batch'
  get '/new_delete_file_batch', to: 'files#new_delete_file_batch'
  post '/store_file_batch', to: 'files#store_file_batch'
  delete '/delete_file_batch', to: 'files#delete_file_batch'


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
