Rails.application.routes.draw do
  devise_for :users

  #shorten login url from users/login to login
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  #shorten logout url from users/logout to logout
  devise_scope :user do
    delete 'logout', to: 'devise/sessions#destroy'
  end

  root to: 'pages#home'

  resources :users, only: [ :index, :show ] do
    resources :services
  end

  resources :services, only: [ :index, :destroy ]

end
