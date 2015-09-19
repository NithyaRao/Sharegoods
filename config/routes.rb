Rails.application.routes.draw do

  get 'invitations/new'

  get 'invitation/new'

  devise_for :users
  resources :users, only: [:update]
  get 'welcome/index'

  resources :groups, only: [:show,:new,:create,:edit, :index]
  root to: 'welcome#index'

  end