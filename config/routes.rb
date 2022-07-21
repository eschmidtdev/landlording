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
    get '/email_confirmation', to: 'registrations#email_confirmation'
  end

  resources :properties do
    collection do
      get :fetch_landlord
    end
  end
  resources :users do
    member do
      get :confirm_email
    end
  end
  resources :visitors, only: :index
  resources :subscriptions do
    member do
      get '/cancel', to: 'subscriptions#cancel_subscription'
    end
  end
  resources :account_settings, except: :index do
    member do
      get '/change/password', to: 'account_settings#change_password'
    end
  end
  resources :rental_applications, only: :index
  resources :payment_details, only: %i[index update]

  get '/documents', to: 'documents#index'
  get '/account', to: 'account_settings#account_index'
  get '/create/interview', to: 'documents#create_interview'
  get '/complete/interview', to: 'documents#complete_interview'
  get 'properties/get_zip_data/:code', controller: 'properties', action: 'get_zip_data'

  # resources :documents do
  #   member do
  #     get :export
  #     get :generate_pdf
  #   end
  # end

end
