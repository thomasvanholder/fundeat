Rails.application.routes.draw do
  root to: 'pages#home'
  resources :campaigns, only: [:new, :create, :edit, :update, :show, :index] do
    resources :investments, only: [:new, :create, :show]
  end
  # resources :investments, only: [:show]

  get 'investments', to: 'investments#index', as: :investments
  get 'own_campaigns', to: 'campaigns#own', as: :own_campaigns

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

