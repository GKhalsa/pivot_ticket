Rails.application.routes.draw do
  root to: "events#index"
  resources :tickets, only: [:index, :update, :create]
  resources :events, only: [:index, :new, :create]
  resource :cart, only: [:create, :show, :destroy, :update]
  resource :users, only: [:create, :update]
  resources :orders, only: [:create, :index, :show]

  get "/venues/:name/events/:id", to: "events#show", as: "event"
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
    resources :venues, only: [:new, :create, :index, :edit]
    resources :venue_moderators, only: [:index, :show, :new, :create, :destroy]
  end

  get "/qr/:id", to: "tickets#qr", as: :ticket_qr

  post "/tickets/:id/de_activate", to: "tickets#de_activate", as: :ticket_deactivate
  post "/tickets/:id/activate", to: "tickets#activate", as: :ticket_activate
  post "admin/tickets/:id/de_activate", to: "admin/tickets#de_activate", as: :admin_ticket_deactivate
  post "admin/tickets/:id/activate", to: "admin/tickets#activate", as: :admin_ticket_activate

  get "/:name", to: "categories#show", as: :category
  get "/:venue/events", to: "venues#show", as: :venue
  get "/admin/:venue/events/new", to: "admin/events#new", as: :new_admin_event
  get "/admin/:venue/events/:id/edit", to: "admin/events#edit", as: :edit_admin_event
  post "/admin/:venue/events", to: "admin/events#create", as: :admin_events
  patch "/admin/:venue/events", to: "admin/events#update", as: :admin_event
  delete "/admin/:venue/events/:id", to: "admin/events#destroy", as: :delete_admin_event
  get "/admin/venues/:venue", to: "admin/venues#show", as: :admin_venue
  patch "/admin/venues/:id", to: "admin/venues#update"
end
