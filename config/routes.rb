Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:update]
  resources :invitations
  get 'welcome/index'
  get 'signup/:invitation_token', to: 'devise/registrations#new', as: 'signup'

  resources :groups, only: [:show,:new,:create,:edit, :index]
  root to: 'welcome#index'

  end