Rails.application.routes.draw do
  namespace :admin do
    resources :system_commands, only: [:index, :update]
    resources :redde_photos, only: [:create, :destroy] do
      post 'sort', on: :collection
    end
  end
end
