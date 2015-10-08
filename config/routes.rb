Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:update]
  resources :invitations
   get 'welcome/index'
  get 'signup/:invitation_token', to: 'devise/registrations#new', as: 'signup'

  resources :groups, except: [:delete] do
    resources :items 
    resources :wishitems
  end 
  resources :items, only: [:index] do
     resources :requests, except: [:delete]

  end
  get "fetch_items/:category_id" => 'items#from_category', as: 'fetch_items'
  get "fetch_sharerequests/" => 'requests#sharerequests', as: 'fetch_sharerequests'
  get "fetch_groupmembers/:group_id" => 'groups#getmembers', as: 'fetch_groupmembers'
  post "items/sendmessage" => 'items#sendmessage', :as => :send_message_item
  post "items/:item_id/requests/:request_id/acceptrequest" => "requests#accept_request", as: 'accept_request'
  get "new_wishitem_have_path/:wishitem_id" => "wishitems#add_to_items", as: 'add_wishtoitem'
  root to: 'welcome#index'

  end