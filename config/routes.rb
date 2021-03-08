Rails.application.routes.draw do
  devise_for :users

  #shorten login url from users/login to login
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    delete 'logout', to: 'devise/sessions#destroy'
  end

  root to: 'pages#home'

  get '/search', to: 'pages#search', as: 'search_page'

  get '/vendors', to: 'pages#vendors', as: 'vendors'
  get '/users', to: 'pages#users', as: 'users'

  resources :jobs, only: [:show] do
    resources :reviews, only: [ :new, :create ]
  end

  resources :jobs, only: [:index, :new, :create ]

  resources :services

  resources :users, only: [ :show ] #revert back
end
