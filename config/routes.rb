Rails.application.routes.draw do
  use_doorkeeper
  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"

  get '/posts', to: 'posts#index'
  get '/comments', to: 'comments#index'
  resources :friendables, only: [:create, :update, :destroy]
  root to: "welcome#index"
  resources :users do
    resources :posts do
      resources :comments
    end
  end
end
