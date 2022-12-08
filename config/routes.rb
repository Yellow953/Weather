Rails.application.routes.draw do
  resources :results

  get "/test", to: "application#test", as:"test"

  root "application#index"
end