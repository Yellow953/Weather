require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  resources :subs
  resources :results

  mount Sidekiq::Web => '/sidekiq'

  get "/daily_weather", to: "application#daily_weather", as: "daily_weather"
  get "/subscribe", to: "application#subscribe", as:"subscribe"
  get "/test", to: "application#test"

  root "application#index"
end