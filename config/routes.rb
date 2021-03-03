Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :services

  # show all services from all users
  # show all services from 1 user (nested within user)
  # show 1 service
  # create new service
  # update service
  # delete service
end
