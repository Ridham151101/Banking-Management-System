Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'home/index'
  post 'home/approve_account_request/:id', to: 'home#approve_account_request', as: 'approve_account_request'
  
  resources :employees, only: [:new, :create]
  resources :customers, only: [:new, :create]
  root to: "home#index"
end
