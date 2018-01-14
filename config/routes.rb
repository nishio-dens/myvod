Rails.application.routes.draw do
  root to: "home#index"

  namespace :api do
    resources :home, only: [:index]
  end
end
