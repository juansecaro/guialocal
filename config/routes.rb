Rails.application.routes.draw do

  root 'empresas#home'
  get '/empresas-ordenadas', to: 'empresas#empresas_ordenadas'
  get '/empresas/:id/horarios', to: 'empresas#horarios'
  get '/mispromos', to: 'promos#mispromos'
  get '/ofertas-y-promociones', to: 'promos#index'
  get '/historia', to: 'info#historia'
  get '/turismo', to: 'info#turismo'
  get '/turismoactivo', to: 'info#turismoactivo'
  get '/alojamiento', to: 'info#alojamiento'
  get '/gastronomia', to: 'info#gastronomia'
  get '/naturaleza', to: 'info#naturaleza'
  get '/ocio', to: 'info#ocio'
  get '/mercadillo-digital', to: 'suscriptors#new'
  get '/guiaturistico', to: 'info#guiaturistico'
  get '/publica', to: 'info#publica'
  get '/novedades', to: 'info#novedades'
  get '/publicitate', to: 'info#publicitate'
  get '/agradecimientos', to: 'info#agradecimientos'
  get '/quejasysugerencias', to: 'info#quejasysugerencias'
  get '/precios', to: 'info#precios'
  get '/preguntasfrecuentes', to: 'info#preguntasfrecuentes'
  get '/cookies', to: 'info#cookies'
  get '/politicadeprivacidad', to: 'info#privacidad'
  get '/condicionesdeuso', to: 'info#condicionesdeuso'
  get '/consiguemascreditos', to: 'info#consiguemascreditos'
  get '/comparativa-promociones', to: 'info#comparativa_promociones'
  get '/gesteventos', to: 'eventos#editor_index'


  devise_for :users, controllers: {
        registrations: 'users/registrations'
      }

  resources :mapas, only: [:show, :index]
  resources :eventos
  resources :charges
  resources :puntos, only: [:show, :index]
  resources :incidents, only: [:new, :create, :show]
  resources :empresas
  resources :contacts, only: [:new, :create]
  resources :categories, only: [:index, :show]
  resources :tags, only: [:index, :show]
  resources :promos, only: [:show, :new, :create]
  resources :achievement_proposals, only: :show

  resources :suscriptors do
    member do
      get :confirm_email
    end
  end

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
    resources :destacados
    resources :puntos
    resources :maps
    resources :achievement_proposals
    resources :categories, except: [:show]
    resources :tags, only: [:index, :show, :destroy]
    resources :incidents do
      resources :comments
    end
  end

  namespace :admin do
    root 'application#index'
    resources :users, only: [:show, :index, :edit, :update]
    resources :eventos, except: [:show]
    resources :tags, only: [:index, :show, :destroy]
    resources :promos, only: [:index, :edit, :update, :destroy]
    resources :incidents do
      resources :comments
    end
    resources :empresas
    resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
  end

end
