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
  end
  root to: 'home#index'
  devise_for :users, controllers: { registrations: 'registrations', invitations: 'invitations' }
  resources :users
  get :reports, to: 'reports#index'
end
