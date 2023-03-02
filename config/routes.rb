Rails.application.routes.draw do
  resources :tasks do
    collection do
      get 'created_order_desc'
    end
  end
  
  root to: 'tasks#index'
end
