Rails.application.routes.draw do
  resources :results
  devise_for :users

  root "application#index"
end