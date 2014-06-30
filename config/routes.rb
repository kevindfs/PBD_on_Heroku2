ActiveCab::Application.routes.draw do
  
  resources :offer_vehicles

  resources :travel_requests

  resources :owners

  get "roles/index"
  resources :schedulings

  resources :clients

  resources :enterprise_clients

  resources :natural_clients

  resources :travels

  resources :travel_requests

  devise_for :users
  get "admin/index"
  get "admin/costos_otros"
  get "admin/usuarios"
  resources :bills

  resources :concepts

  resources :states

  resources :state_histories

  resources :external_enterprises

  resources :owners

  resources :vehicles

  resources :assigneds

  resources :drivers

  resources :scheduling_blocks

  resources :offer_vehicles

  resources :comunnes

  resources :fixed_rates

  resources :owner_commissions

  resources :technical_review_expirations

  resources :kilometers_prices

  resources :base_prices

  resources :technical_review_alerts

  resources :drivers_license_alerts

  resources :log_sqls

  get "gestiones/index"
  get "gestiones/gestion_moviles"
  get "gestiones/gestion_tarifas"
  get "gestiones/gestion_informacion"
  get "gestiones/gestion_convenios"
  get "operador/index"
  get "operador/solicitudes"
  get "operador/disp_conductor"
  get "operador/usuarios_reg"
  get "gestion_usuarios/index"
  get "gestion_usuarios/gestion_conductores"
  get "gestion_usuarios/gestion_empresas"
  get "gestion_usuarios/gestion_operadores"
  get "gestion_usuarios/gestion_propietarios"
  get "conductor/index"
  get "conductor/calendario"
  get "cliente/estado"
  get "cliente/solicitud"
  get "cliente/condiciones"
  get "log/iniciar"
  get "log/registrar"
  get "welcome/reserva"
  get "welcome/qs"
  get "welcome/tarifas"
  get "welcome/contacto"
  get "home/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

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
  post ':controller(/:action(/:id))'
  get ':controller(/:action(/:id))'  
  # match ':controller(/:action(/:id))'  
   
end
