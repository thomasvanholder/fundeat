Rails.application.routes.draw do
  root to: 'pages#home'
  resources :campaigns, only: [:new, :create, :edit, :update, :show, :index] do
    resources :investments, only: [:new, :create]
  end
  resources :investments, only: [:show] do
    resources :reward_redemptions, only: [:create]
  end

  get 'investments', to: 'investments#index', as: :investments

  get 'raising', to: 'campaigns#raising', as: :raising

  get 'mycampaigns/owners_dashboard', to: 'campaigns#owners_dashboard', as: :owners_dashboard
  get 'mycampaigns', to: 'campaigns#mycampaigns', as: :mycampaigns
  get 'mycampaigns/myrewards', to: 'campaigns#rewards', as: :owners_rewards
  get 'mycampaigns/support', to: 'campaigns#support', as: :owners_support

  get 'myinvestments/dashboard', to: 'investments#dashboard', as: :investors_dashboard
  get 'myinvestments', to: 'investments#myinvestments', as: :myinvestments
  get 'myinvestments/myrewards', to: 'investments#rewards', as: :investors_myrewards
  get 'myinvestments/mymap', to: 'investments#map', as: :investors_mymap

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

