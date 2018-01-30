Rails.application.routes.draw do
  root to: "home#index"

  namespace :api, defaults: { format: :json } do
    resources :home, only: [:index]
  end
end
