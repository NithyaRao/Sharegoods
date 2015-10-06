Rails.application.routes.draw do

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
  get "fetch_items/:category_id" => 'items#from_category', as: 'fetch_items'
  get "fetch_sharerequests/" => 'requests#sharerequests', as: 'fetch_sharerequests'
  post "items/sendmessage" => 'items#sendmessage', :as => :send_message_item
  post "items/:item_id/requests/:request_id/acceptrequest" => "requests#accept_request", as: 'accept_request'
  root to: 'welcome#index'

  end