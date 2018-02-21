Rails.application.routes.draw do
  resources :empresas
  namespace :admin do
    root 'application#index'
    resources :users, only: [:index, :show, :edit, :delete]
    resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  devise_for :users
  resources :users, only: :show
  resources :categories, only: :show
  resources :tags, only: :show
  resources :promos, only: [:show, :index]

  root 'empresas#index'


end
