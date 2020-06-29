Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "searches#index"
  resources :searches, only: [:index]
  resources :movies, only: [:create, :update, :destroy]
end
