Rails.application.routes.draw do
  devise_for :users

  #shorten login url from users/login to login
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    delete 'logout', to: 'devise/sessions#destroy'
  end

  root to: 'pages#home'
  get '/search', to: 'pages#search', as: 'search_page'


  resources :services do
    resources :jobs, only: [:new, :create]
  end

  resources :jobs, only: [:index, :show] do
    resources :reviews, only: [ :new, :create ]
  end

  # resources :jobs, only: [:index, :new, :create ]

  resources :users, only: [ :show ] #revert back

  # vendor route to find vendor
  get '/vendors/:id', to: 'pages#vendors_show', as: 'vendor'

  # vendors routes to show available vendors
  get '/vendors', to: 'pages#vendors', as: 'vendors'


end
