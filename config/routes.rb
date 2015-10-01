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
  get "items/new_request/:item_id" => 'items#new_request', :as => :new_request
  
  root to: 'welcome#index'

  end