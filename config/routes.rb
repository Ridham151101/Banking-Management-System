Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :employees
  resources :customers, only: [:index, :new, :create]
  resources :transactions, only: [:index, :new, :create]
  resources :employee_transactions, only: [:new, :create]
  resources :favorite_recipients, only: [:index, :new, :create, :destroy]

  get 'home/home'
  get 'accounts/account_details', to: 'home#account_details', as: 'account_details'
  get 'accounts/new', to: 'home#new_account', as: 'new_account'
  post 'home/approve_account_request/:id', to: 'home#approve_account_request', as: 'approve_account_request'
  
  root to: "home#home"
end
