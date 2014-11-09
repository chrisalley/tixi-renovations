Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  devise_scope :user do
    get 'log-in', to: 'sessions#create'
    get 'log-out', to: 'sessions#destroy', as: :destroy_user_session
  end

  resources :enquiries
  resources :pages
  resources :photo_pairs, path: 'photo-pairs'
  resources :users
  get 'enquiry', to: 'enquiries#new'
  get 'gallery', to: 'photo_pairs#gallery', as: :gallery

  get ':id', to: 'pages#show'
  root to: 'pages#show'
end
