Rails.application.routes.draw do
  devise_for :users

  #shorten login url from users/login to login
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    delete 'logout', to: 'devise/sessions#destroy'
  end

  root to: 'pages#home'
  get '/search', to: 'pages#search', as: 'search_page'

  resources :jobs, only: [:show, :index, :new, :create] do
    resources :reviews, only: [ :new, :create ]
  end

  resources :services

  resources :users, only: [ :show ] #revert back
end
