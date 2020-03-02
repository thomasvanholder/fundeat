Rails.application.routes.draw do
  root to: 'investments#index'
  get 'campaigns/new'
  get 'campaigns/create'
  get 'campaigns/edit'
  get 'campaigns/update'
  get 'campaigns/show'
  get 'campaigns/index'
  get 'investments/index'
  get 'investments/show'
  get 'investments/new'
  get 'investments/create'
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
