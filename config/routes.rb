Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'

  get 'welcome/about'
  get 'registers' =>  'welcome#index'

  root to: 'welcome#index'

  end