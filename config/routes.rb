Rails.application.routes.draw do
  use_doorkeeper
  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"

  get '/comments', to: 'comments#index'
  resources :friendables
  root to: "welcome#index"
  resources :users do
    resources :posts do
      resources :comments
    end
  end
end
