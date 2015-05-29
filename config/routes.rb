require 'api_constraints'

Rails.application.routes.draw do
  
	
  	# routes setup
  	root 'api/v1/stores#index'
    get '/about', to: 'static_pages#about_page'
    get '/faq', to: 'static_pages#FAQ_page'
    
    # devise gem
    devise_for :users

    # rails admin
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

    # api setup
    namespace :api, constraints: {subdomain: 'warm-cove-8503'}, path: '/' do
      scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
        resources :users do
          resources :stores, only: [:create, :new, :update, :edit]
        end
        resources :stores, only: [:index, :show, :destroy]
        resources :sessions, only: [:create, :destroy]
        resources :categories, only: [:index]
      end
  end
  
end
