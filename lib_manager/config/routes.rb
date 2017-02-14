Rails.application.routes.draw do
  root "pages#show", page: "home"

  get "/pages/*page", to: "pages#show"

  get "signup", to: "users#new"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, expert: [:index, :new] do
    resources :borrow_books, only: [:create, :destroy]
  end
  resources :books, only: [:index, :show] do
    resources :comments, only: :create
  end
  resources :categories, only: :show do
    resources :books, only: [:index, :show]
  end

  namespace :admins do
    get "/create", to: "users#new"
    get "/create/book", to: "books#new"
    get "/create/publisher", to: "publishers#new"
    resources :users, except: [:new]
    resources :books, except: [:new]
    resources :publishers, except: [:new]
    resources :borrow_books, only: [:index, :update, :destroy]
  end
end
