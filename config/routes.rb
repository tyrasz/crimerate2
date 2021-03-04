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

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
