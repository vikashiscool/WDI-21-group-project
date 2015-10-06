Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"

  root to: "welcome#index"
  resources :users do
    resources :posts do
      resources :comments
    end
  end
end
