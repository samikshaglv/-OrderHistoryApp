Rails.application.routes.draw do
  resources :users, only: [:index] do
    member do
      get :download_orders
      get :download_csv
    end
  end
  get "up" => "rails/health#show", as: :rails_health_check

  root 'users#index'
end
