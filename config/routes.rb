Rails.application.routes.draw do
  root to: "events#index"
  resources :events, only: [:show, :index, :new, :create]
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
    # resources :events, only: [:new, :create]
    resources :venues, only: [:new, :create, :index, :edit]
    resources :venue_moderators, only: [:index, :show, :new, :create]
  end

  get "/:name", to: "categories#show", as: :category
  get "/:venue/events", to: "venues#show", as: :venue

  get "/admin/:venue/events/new", to: "admin/events#new", as: :new_admin_event
  get "/admin/:venue/events/:id/edit", to: "admin/events#edit", as: :edit_admin_event
  post "/admin/:venue/events", to: "admin/events#create", as: :admin_events
  patch "/admin/:venue/events", to: "admin/events#update", as: :admin_venue_event
  delete "/admin/:venue/events/:id", to: "admin/events#destroy", as: :delete_admin_event
  # get "/admin/:venue/edit", to: "admin/venues#edit", as: :edit_admin_venue
  get "/admin/venues/:venue", to: "admin/venues#show", as: :admin_venue
  patch "/admin/venues/:id", to: "admin/venues#update"
  # patch "/admin/:venue", to: "admin/venues#update"

end
