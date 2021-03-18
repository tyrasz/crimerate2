Rails.application.routes.draw do
  devise_for :users

  #shorten login url from users/login to login
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    delete 'logout', to: 'devise/sessions#destroy'
  end

  root to: 'pages#home'
  get '/search', to: 'pages#search', as: 'search_page'
  get "/about", to: "pages#about", as: 'about_page'

  get '/jobs/nearby', to: 'jobs#nearby', as: 'jobs_nearby'

  resources :jobs, only: [:index, :show, :destroy] do
    resources :reviews, only: [ :new, :create, :index ]
  end

  resources :services do
    resources :jobs, only: [:new, :create]
  end

  resources :users, only: [ :show ] #revert back

  # vendor route to find vendor
  get '/vendors/:id', to: 'pages#vendors_show', as: 'vendor' do
    resources :reviews, only: [ :index ]
  end

  # vendors routes to show available vendors
  get '/vendors', to: 'pages#vendors', as: 'vendors'

  get '/vendors/:id/services', to: 'services#byvendors', as: 'byvendors'

  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
  end

  mount StripeEvent::Engine, at: '/stripe-webhooks'

end
