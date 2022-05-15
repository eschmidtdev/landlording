# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  devise_scope :user do
    get '/auth/google_oauth2/callback', to: 'sessions#google_auth'
    get '/signup', to: 'registrations#index'
    get '/', to: 'sessions#index'
    root to: 'sessions#index'
  end
  resources :users do
    member do
      get :confirm_email
    end
  end
  # resources :documents do
  #   member do
  #     get :export
  #     get :generate_pdf
  #   end
  # end
  get '/documents', to: 'documents#index'
  get '/create/interview', to: 'documents#create_interview'
  get '/complete/interview', to: 'documents#complete_interview'
  resources :subscriptions, only: %i[index update] do
    collection do
      get :plans
    end
  end
  resources :payments, only: :index
  resources :visitors, only: :index
end
