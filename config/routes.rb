Votation::Application.routes.draw do

  mount RedactorRails::Engine => '/redactor_rails'
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
  root to: 'home#index'
  devise_for :users, controllers: { registrations: 'registrations', invitations: 'invitations' }
  resources :users
  resource :organisation, only: [:edit, :update] do
    resource :subscriptions
  end
  get :reports, to: 'reports#index'
end
