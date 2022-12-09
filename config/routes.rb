require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  resources :subs
  resources :results

  mount Sidekiq::Web => '/sidekiq'

  get "/subscribe", to: "application#subscribe", as:"subscribe"

  root "application#index"
end