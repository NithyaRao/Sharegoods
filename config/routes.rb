Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:update]
  get 'welcome/index'

  resources :groups, only: [:show,:new,:create,:edit, :index]
  root to: 'welcome#index'

  end