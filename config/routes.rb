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
  get "fetch_items/:category_id" => 'items#from_category', as: 'fetch_items'
  get "fetch_shareitems/" => 'items#shareitems_requests', as: 'fetch_shareitems'
  post "items/sendmessage" => 'items#sendmessage', :as => :send_message_item
  post "items/:item_id/acceptrequest" => "items#accept_request", as: 'accept_request'
  root to: 'welcome#index'

  end