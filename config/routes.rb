Rails.application.routes.draw do

  devise_for :users
  get 'welcome/index'

  resources :groups, only: [:show,:new,:create,:edit, :index]
  root to: 'welcome#index'

  end