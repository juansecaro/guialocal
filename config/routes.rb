Rails.application.routes.draw do

  get '/historia', to: 'info#historia'
  get '/turismo', to: 'info#turismo'
  get '/turismoactivo', to: 'info#turismoactivo'
  get '/alojamiento', to: 'info#alojamiento'
  get '/gastronomia', to: 'info#gastronomia'
  get '/naturaleza', to: 'info#naturaleza'
  get '/ocio', to: 'info#ocio'
  get '/guiaturistico', to: 'info#guiaturistico'
  get '/publica', to: 'info#publica'

  resources :eventos
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
