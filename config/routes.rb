Rails.application.routes.draw do

  devise_for :users
  get 'welcome/index'

  resources :groups, only: [:show,:new,:create,:edit, :index]
  resources :memberships, only:[:new, :create]
  root to: 'welcome#index'

  end