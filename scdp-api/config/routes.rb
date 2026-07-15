Rails.application.routes.draw do
  require "sidekiq/web"

  namespace :admin do
    resources :users
  end

  mount Sidekiq::Web => "/sidekiq"
  mount ActionCable.server => "/cable"

  get "/me", to: "me#show"

  match "/auth/:provider/callback",
      to: "auth#google",
      via: [:get, :post]

  get "/auth/failure", to: "auth#failure"

  scope :pauses, module: :pauses do
    post :reserve, to: "pauses#reserve"

    post ":id/start", to: "pauses#start"
    post ":id/finish", to: "pauses#finish"

    get :current, to: "pauses#current"
    get :history, to: "pauses#history"
  end

  get "/teams/:id/pause_board", to: "teams#pause_board"
end

