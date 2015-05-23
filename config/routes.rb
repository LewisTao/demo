require 'api_constraints'

Rails.application.routes.draw do
  
	
  	# routes setup
  	root 'static_pages#home_page'
    get '/about', to: 'static_pages#about_page'
    get '/faq', to: 'static_pages#FAQ_page'
    

  	# api setup
  	namespace :api, defaults: {format: :json}, constraints: {subdomain: 'api'}, path: '/' do
    	scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
        resources :users do
          resources :stores, only: [:create, :new, :update, :edit]
        end
        resources :stores, only: [:index, :show, :destroy]
        resources :sessions, only: [:create, :destroy]
      end
	end

  # devise gem
  devise_for :users

  # rails admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

end
