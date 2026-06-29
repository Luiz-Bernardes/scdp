Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/me", to: "me#show"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
  
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

  # Defines the root path route ("/")
  # root "posts#index"
end

