Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update]
  resources :product_models, only: [:index, :new, :create, :show]
end
