Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :users, only: [ :index, :show ] do
    resources :services
  end

  resources :services, only: [ :index, :destroy ]

  # show all services from all users
  # show all services from 1 user (nested within user)
  # show 1 service
  # create new service
  # update service
  # delete service
end
