# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  devise_scope :user do
    get '/auth/google_oauth2/callback', to: 'sessions#google_auth'
  end
  resources :users do
    member do
      get :confirm_email
    end
  end
  resources :documents do
    member do
      get :export
      get :generate_pdf
    end
  end
  resources :subscriptions, only: %i[index update] do
    collection do
      get :plans
    end
  end
  resources :payments, only: :index
end
