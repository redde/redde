Rails.application.routes.draw do
  devise_for :managers, controllers: { registrations: 'managers/registrations' } if defined?(Devise)
  mount Redde::Engine, at: '/redde'
  root to: "articles#index"

  namespace :admin do
    root to: 'articles#index'
    resources :articles
    resources :managers
  end
end
