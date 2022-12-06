Rails.application.routes.draw do
  devise_for :users

  get "/:city", to: "application#selected_city", as: "selected_city"

  root "application#index"
end