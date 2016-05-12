Rails.application.routes.draw do
  root to: "tickets#index"

  resources :tickets, only: [:index]
  resource :cart, only: [:create, :show, :destroy, :update]
  resource :users, only: [:create]
  resources :orders, only: [:create, :index, :show]

  get "/login", to: "users#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/auth/github", as: :github_login
  get "/auth/github/callback", to: "sessions#create"
  get "/dashboard", to: "orders#index"

  namespace :admin do
    get "/dashboard", to: "dashboard#show"
    patch "/tickets/:id/retire", to: "tickets#retire", as: :retire
    patch "/tickets/:id/activate", to: "tickets#activate", as: :activate
    patch "/orders/:id/cancel", to: "orders#cancel", as: :cancel
    resources :tickets, only: [:index, :new, :create, :edit, :update]
    resources :orders, only: [:index, :update]
    resources :categories, only: [:new, :create]
    resources :events, only: [:new, :create]
  end

  get "/:name", to: "categories#show", as: :category
  get "/:venue/events", to: "venues#show", as: :venue
  # get "/:venue/events/:id", to: "tickets#index", as: :event_tickets
end
