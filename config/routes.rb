Ithaka::Application.routes.draw do

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  mount RedactorRails::Engine => '/redactor_rails'

  namespace :api, defaults: {format: 'json'} do
    resources :projects do
      resources :ideas do
        resources :comments
        resources :influences, only: [:update, :index, :show]
      end
    end
  end

  resources :projects do
    resources :ideas do
      resources :votes
      resources :comments
      resources :favourites, only: [:create, :destroy]
      resources :influences, only: [:update]
      get :unlock, on: :member
      get :release, on: :member
    end
    resources :factors
  end
  root to: 'high_voltage/pages#show', id: 'home'
  devise_for :users, controllers: { registrations: 'registrations',
                                    invitations: 'invitations',
                                    omniauth_callbacks: 'omniauth_callbacks' }
  resources :users
  resource :organisation, only: [:edit, :update] do
    resource :subscriptions
  end
  resource :google_admin, only: [:show] do
    get :callback, on: :member
    get :authenticate, on: :member
    put :invite_all, on: :member
  end
  get :reports, to: 'reports#index'
  get :search, to: 'search#index', as: :search
end
