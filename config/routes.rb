Rails.application.routes.draw do
  root to: 'pages#home'
  resources :campaigns, only: [:new, :create, :edit, :update, :show, :index] do
    resources :investments, only: [:new, :create]
  end
  resources :investments, only: [:show]

  get 'investments', to: 'investments#index', as: :investments
  get 'my_campaigns', to: 'campaigns#my_campaigns', as: :my_campaigns
  get 'my_campaigns/support', to: 'campaigns#support', as: :support

  get 'investments/dashboard', to: 'investments#dashboard', as: :investors_dashboard

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

