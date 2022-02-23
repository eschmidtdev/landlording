# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  resources :users do
    member do
      get :confirm_email
    end
  end
  resources :documents
  resources :subscriptions do
    collection do
      get :plans
    end
  end
  resources :payments, only: :index
end
