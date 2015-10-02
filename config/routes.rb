Rails.application.routes.draw do

  get 'requests/index'

  get 'requests/show'

  get 'requests/new'

  get 'requests/edit'

  devise_for :users
  resources :users, only: [:update]
  resources :invitations
   get 'welcome/index'
  get 'signup/:invitation_token', to: 'devise/registrations#new', as: 'signup'

  resources :groups, except: [:delete] do
    resources :items
  end 
  resources :items, only: [:index] do
     resources :requests, except: [:delete]
  end
  get "/fetch_items" => 'items#from_category', as: 'fetch_items'
  get "items/new_request/:item_id" => 'items#new_request', :as => :new_request
  post "items/sendmessage" => 'items#sendmessage', :as => :send_message_item
  
  root to: 'welcome#index'

  end