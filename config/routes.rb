Rails.application.routes.draw do
  resources :campaigns

  root "campaigns#index"
end
