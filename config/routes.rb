Rails.application.routes.draw do
  get "admin" => "admin#index"
  get "admin/index"
  resource :session
  resources :passwords, param: :token

  scope "(:locale)", locale: /en|es/ do
    resources :orders
    resources :line_items
    resources :carts
    root "store#index", as: "store_index", via: :all
  end

  resources :products
  resources :support_requests, only: %i[ index update ]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
