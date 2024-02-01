Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  #Productos
  get 'products', to: 'api/v1/products#products'
  get 'product/:id', to: 'api/v1/products#show'
  post 'new_product', to: 'api/v1/products#create'
  put 'update_product/:id', to: 'api/v1/products#update'
  delete 'delete_product/:id', to: 'api/v1/products#destroy'


  #Ordenes
  get 'orders', to: 'api/v1/orders#orders'
  get 'order/:id', to: 'api/v1/orders#show'
  post 'new_order', to: 'api/v1/orders#create'
  put 'update_order/:id', to: 'api/v1/orders#update'
  delete 'delete_order/:id', to: 'api/v1/orders#destroy'
  put 'update_status/:num_order', to: 'api/v1/orders#update_status'

  #users 
  get 'users', to: 'api/v1/users#users'
  get 'user/:id', to: 'api/v1/users#show'
  post 'new_user', to: 'api/v1/users#create'
  put 'update_user/:id', to: 'api/v1/users#update'
  delete 'delete_user/:id', to: 'api/v1/users#destroy'

  #Autenticación
  post 'auth/login', to: 'api/v1/authentication#login'

end
