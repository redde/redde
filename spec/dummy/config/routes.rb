Rails.application.routes.draw do
  # devise_for :managers, controllers: { registrations: 'managers/registrations' }
  root to: "articles#index"
end
