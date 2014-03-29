Votation::Application.routes.draw do

  resources :projects do
    resources :ideas do
      resource :votes
      resource :comments
    end
  end
  root to: 'home#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users
end
