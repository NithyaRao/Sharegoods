Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
end
  resources :users, only: [:update]
  resources :invitations
   get 'welcome/index'
  get 'signup/:invitation_token', to: 'devise/registrations#new', as: 'signup'

  resources :groups, except: [:delete] do
    resources :items, only: [:create, :new] 
    resources :wishitems
   end 
  resources :items, only: [:show] do
     resources :requests, except: [:delete]
  end


  get "fetch_items/:category_id" => 'items#from_category', as: 'fetch_items'
  get "fetch_sharerequests/" => 'requests#sharerequests', as: 'fetch_sharerequests'
  get "fetch_memberrequests/" => 'requests#memberrequests', as: 'fetch_memberrequests'
  get "fetch_groupmembers/:group_id" => 'groups#getmembers', as: 'fetch_groupmembers'
  post "items/sendmessage" => 'items#sendmessage', :as => :send_message_item
  post "items/:item_id/requests/:request_id/acceptrequest" => "requests#accept_request", as: 'accept_request'
  get "member_has_wishitem_path/:wishitem_id" => "wishitems#member_has_wishitem", as: 'member_has_wishitem'
  post "wishitems/:wishitem_id/addwishtomembershare" => "wishitems#add_to_items", as: 'add_wish_membershare'
 
  root to: 'welcome#index'

  end