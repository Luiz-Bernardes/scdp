Rails.application.routes.draw do
  mount ActionCable.server => "/cable"

  get "/me", to: "me#show"

  match "/auth/:provider/callback",
      to: "auth#google",
      via: [:get, :post]

  get "/auth/failure", to: "auth#failure"

  scope :pauses, module: :pauses do
    post :start, to: 'pauses#start'
    post ':id/finish', to: 'pauses#finish'
    get :current, to: 'pauses#current'
    get :history, to: 'pauses#history'
  end
end

