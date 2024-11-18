Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "pages#home" , as: "home"

  get "/produit/:id", to: "pages#produit" , as: "product"

  get "/admin", to: "pages#admin" , as: "admin"

  get "/espacepersonnelle", to: "pages#espacepersonnelle", as: "espace"

  get "/achatproduit/:id", to: "pages#achatproduit", as: "achatproduit"


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
