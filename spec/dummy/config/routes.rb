Rails.application.routes.draw do
  # devise_for :managers, controllers: { registrations: 'managers/registrations' }
  mount Redde::Engine, at: '/'
  root to: "articles#index"
end
