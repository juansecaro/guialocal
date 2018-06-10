Rails.application.routes.draw do


  namespace :superadmin do
    root 'application#index'
    get 'configs', to: 'config#edit'
    patch 'configs', to: 'config#update'
    post '/creditos/update', to: 'creditos#update'
    get '/creditos/edit', to: 'creditos#edit'
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :empresas
    resources :promos, only: [:index, :edit, :update, :destroy]
    resources :eventos, except: [:show]
    resources :tags, only: [:index, :show, :destroy]
  end



  root 'empresas#home'
  get '/empresas_ordenadas', to: 'empresas#empresas_ordenadas'
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
  resources :puntos
  resources :incidents, only: [:new, :create, :show]
  resources :empresas
  resources :categories, only: [:index, :show]
  resources :tags, only: [:index, :show]
  resources :promos, only: [:show, :index, :new, :create]




end
