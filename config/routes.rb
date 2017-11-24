Rails.application.routes.draw do
  resources :empresas


  root 'empresas#index'


end
