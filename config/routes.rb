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

  resources :jobs do
    resources :reviews
  end

  resources :services do

  end

  resources :users, only: [ :show ] do
  end

end
