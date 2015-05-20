require 'api_constraints'

Rails.application.routes.draw do
  
	
  	# routes setup
  	root 'static_pages#home_page'
    get '/about', to: 'static_pages#about_page'
    get '/FAQ', to: 'static_pages#FAQ_page'
    

  	# api setup
  	namespace :api, constraints: {subdomain: 'api'}, path: '/' do
    	scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
        resources :stores
        resources :users
      end
	end

  # devise gem
  devise_for :users

  # rails admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

end
