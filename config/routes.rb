Rails.application.routes.draw do
  root to: 'pages#home'
  resources :campaigns, only: [:new, :create, :edit, :update, :show, :index] do
    resources :investments, only: [:new, :create]
  end
  resources :investments, only: [:show]

  get 'investments', to: 'investments#index', as: :investments

  get 'raising', to: 'campaigns#raising', as: :raising

  get 'my_campaigns', to: 'campaigns#my_campaigns', as: :my_campaigns
  get 'my_campaigns/support', to: 'campaigns#support', as: :support
  get 'campaigns/dashboard', to: 'campaigns#dashboard', as: :campaigns_dashboard

  get 'investments/dashboard', to: 'investments#dashboard', as: :investors_dashboard
  get 'investments/dashboard/myinvestments', to: 'investments#dashboard_myinvestments', as: :dashboard_myinvestments
  get 'investments/dashboard/myrewards', to: 'investments#dashboard_myrewards', as: :dashboard_myrewards
  get 'investments/dashboard/mymap', to: 'investments#dashboard_mymap', as: :dashboard_mymap

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

