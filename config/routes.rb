Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:update]
  resources :invitations
   get 'welcome/index'
  get 'signup/:invitation_token', to: 'devise/registrations#new', as: 'signup'

  resources :groups, except: [:delete] do
    resources :items
  end 
  get "/fetch_items" => 'items#from_category', as: 'fetch_items'
  
  root to: 'welcome#index'

  end