Rails.application.routes.draw do

  resources :incidents
  get '/historia', to: 'info#historia'
  get '/turismo', to: 'info#turismo'
  get '/turismoactivo', to: 'info#turismoactivo'
  get '/alojamiento', to: 'info#alojamiento'
  get '/gastronomia', to: 'info#gastronomia'
  get '/naturaleza', to: 'info#naturaleza'
  get '/ocio', to: 'info#ocio'
  get '/guiaturistico', to: 'info#guiaturistico'
  get '/publica', to: 'info#publica'
  get '/publicitate', to: 'info#publicitate'
  get '/precios', to: 'info#precios'
  get '/consiguemascreditos', to: 'info#consiguemascreditos'
  get '/mispromos', to: 'promos#mispromos'


  namespace :admin do
    root 'application#index'
    resources :users, only: [:show, :index]
    resources :destacados
    resources :incidents do
      resources :comments
    end
    resources :empresas
    resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
  end



  devise_for :users, controllers: {
        registrations: 'users/registrations'
      }

  resources :eventos
  resources :charges
  resources :incidents, only: [:new, :create, :show]
  resources :empresas
  resources :categories, only: :show
  resources :tags, only: :show
  resources :promos, only: [:show, :index, :new, :create]

  root 'empresas#index'


end
