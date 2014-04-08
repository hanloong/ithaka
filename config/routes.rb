Votation::Application.routes.draw do

  resources :projects do
    resources :ideas do
      resources :votes
      resources :comments
      get :unlock, on: :member
    end
  end
  root to: 'home#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users
end
