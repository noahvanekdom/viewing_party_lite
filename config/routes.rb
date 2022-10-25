Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing#index'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # resource :users, path: 'dashboard'



  resource :users, only: %i[create new show] do
    get '/discover', to: 'users#discover'

    resources :movies, only: %i[index show] do
      resources :parties, only: %i[new create]
    end
  end

  # get '/login', to: 'users#login_form'

  # post '/login', to: 'users#login_user'

  get '/register', to: 'users#new'
end
