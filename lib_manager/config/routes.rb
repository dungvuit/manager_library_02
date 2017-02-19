Rails.application.routes.draw do
  root "books#index"

  get "/pages/*page", to: "pages#show"

  get "signup", to: "users#new"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, expert: [:index, :new] do
    resources :borrow_books, only: [:create, :destroy]
    resources :follow_books, only: [:create, :destroy]
    resources :follow_users, only: [:index, :create, :destroy]
  end
  resources :books, only: [:index, :show] do
    resources :comments, only: :create
  end
  resources :categories, only: :show do
    resources :books, only: [:index, :show]
  end

  namespace :admins do
    resources :users
    resources :books
    resources :publishers
    resources :authors
    resources :categories
    resources :borrow_books, only: [:index, :update, :destroy]
  end
end
