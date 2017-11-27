Rails.application.routes.draw do
  namespace :admin do
    root 'application#index'
    resources :users, only: [:index, :show, :edit, :delete]
    resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  devise_for :users
  resources :users, only: :show
  resources :empresas
  resources :categories, only: :show


  root 'empresas#index'


end
