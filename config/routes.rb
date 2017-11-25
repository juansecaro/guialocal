Rails.application.routes.draw do
  namespace :admin do
    root 'application#index'
  end

  devise_for :users
  resources :empresas


  root 'empresas#index'


end
