Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  devise_scope :user do
    get 'log-in', to: 'sessions#create'
    get 'log-out', to: 'sessions#destroy', as: :destroy_user_session
  end

  resources :pages
  resources :photos, path: 'gallery'
  resources :users

  get ':id', to: 'pages#show'
  root to: 'pages#show'
end
