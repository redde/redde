Rails.application.routes.draw do
  namespace :admin do
    resources :system_commands, only: [:index, :update]
  end
end
