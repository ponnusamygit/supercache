Rails.application.routes.draw do
  mount Supercache::Engine, at: 'supercache'
  
  resources :users, only: :index do
    collection do
      get :http_request
    end
  end
end