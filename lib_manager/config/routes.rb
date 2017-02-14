Rails.application.routes.draw do
  root "pages#show", page: "home"

  get "/pages/*page", to: "pages#show"

  get "signup", to: "users#new"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, expert: [:index, :new]
  resources :books, only: [:index, :show] do
    resources :comments, only: :create
  end
  resources :categories, only: :show do
    resources :books, only: [:index, :show]
  end

  namespace :admins do
    get "/create", to: "users#new"
    resources :users, except: [:new]
  end
end
