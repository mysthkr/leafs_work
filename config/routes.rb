Rails.application.routes.draw do
  resources :tasks do
    collection do
      get 'index_created_desc'
    end
  end
  
  root to: 'tasks#index'
end
