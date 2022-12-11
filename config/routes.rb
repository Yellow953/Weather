require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  resources :subs
  resources :results

  mount Sidekiq::Web => '/sidekiq'

  get "/subscribe", to: "application#subscribe", as:"subscribe"
  get "/test", to: "application#test"

  root "application#index"
end