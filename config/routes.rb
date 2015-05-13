require 'api_constraints'

Rails.application.routes.draw do
	# rails admin
  	mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  	# routes setup
  	root 'static_pages#home_page'
	get '/about', to: 'static_pages#about_page'
  	get '/FAQ', to: 'static_pages#FAQ_page'
  
  	# api setup
  	namespace :api, constraints: {subdomain: 'api'}, path: '/' do
    	scope module: :v1, constraints: ApiConstraints.new(version: 1, default: false) do
    	end
	end
end
