# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  devise_scope :user do
    root to: 'sessions#index'
    get '/', to: 'sessions#index'
    get '/signup', to: 'registrations#index'
    post '/sent/email', to: 'passwords#create'
    get '/confirmation', to: 'passwords#confirmation'
    get '/auth/google_oauth2/callback', to: 'sessions#google_auth'
  end

  resources :users do
    member do
      get :confirm_email
    end
  end
  resources :payments, only: :index
  resources :visitors, only: :index
  resources :properties
  resources :account_settings do
    member do
      get '/change/password', to: 'account_settings#change_password'
    end
  end
  resources :rental_applications, only: :index
  resources :subscriptions do
    member do
      get '/cancel', to: 'subscriptions#cancel_subscription'
    end
  end

  get '/documents', to: 'documents#index'
  get '/create/interview', to: 'documents#create_interview'
  get '/complete/interview', to: 'documents#complete_interview'

  # resources :documents do
  #   member do
  #     get :export
  #     get :generate_pdf
  #   end
  # end

end
