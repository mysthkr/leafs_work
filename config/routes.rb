Rails.application.routes.draw do
  resources :tasks
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  post 'index', to: 'tasks#index'
  root to: 'tasks#index'
end
