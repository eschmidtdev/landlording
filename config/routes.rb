Rails.application.routes.draw do

  resources :subscriptions
  resources :e_forms
  root to: 'visitors#index'
  devise_for :users, controllers: { registrations: "registrations", sessions: "sessions" }
  resources :users

end
