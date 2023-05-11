Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'home/index'
  get 'accounts/new', to: 'home#new_account', as: 'new_account'
  get 'home/approved_customers', to: 'home#approved_customers', as: 'approved_customers'
  post 'home/approve_account_request/:id', to: 'home#approve_account_request', as: 'approve_account_request'
  
  resources :employees
  resources :customers, only: [:index, :new, :create]
  resources :transactions, only: [:index, :new, :create]
  root to: "home#index"
end
