Rails.application.routes.draw do
  root to: "tickets#index"
  resources :tickets, only: [:index, :update, :create]
  resources :events, only: [:show, :index, :new, :create]
  resource :cart, only: [:create, :show, :destroy, :update]
  resource :users, only: [:create, :update]
  resources :orders, only: [:create, :index, :show]

  get "/my-tickets", to: "tickets#my_tickets"
  get "/my-tickets/new", to: "tickets#new"
  get "/my-tickets/edit", to: "tickets#edit"
  get "/account/edit", to: "users#edit"
  get "/login", to: "users#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/auth/github", as: :github_login
  get "/auth/github/callback", to: "sessions#create"
  get "/dashboard", to: "users#dashboard"

  namespace :admin do
    get "/dashboard", to: "dashboard#show"
    post '/venues/:id/de_activate', to: "venues#de_activate", as: "venue_deactivate"
    post '/venues/:id/activate', to: "venues#activate", as: "venue_activate"
    patch "/orders/:id/cancel", to: "orders#cancel", as: :cancel
    resources :tickets, only: [:index, :new, :create, :edit, :update]
    resources :orders, only: [:index, :update]
    resources :categories, only: [:new, :create]
    resources :events, only: [:new, :create]
  end

  post "/tickets/:id/de_activate", to: "tickets#de_activate", as: :ticket_deactivate
  post "/tickets/:id/activate", to: "tickets#activate", as: :ticket_activate

  get "/:name", to: "categories#show", as: :category
  get "/:venue/events", to: "venues#show", as: :venue
  # get "/:venue/events/:id", to: "tickets#index", as: :event_tickets
end
