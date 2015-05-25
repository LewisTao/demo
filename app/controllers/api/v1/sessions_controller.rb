class Api::V1::SessionsController < ApplicationController
	before_action :user_downcase, only: [:create]
	
	def create
		user = User.find_by(email: params[:session][:email])
		if user.present? && user.valid_password?(params[:session][:password])
			sign_in user
			user.generate_authentication_token
			user.save
			render json: user, status: 200, location: [:api, user]
		else
			render json: { errors: "Invalid email or password" }, status: 422
		end
	end

	def destroy
		user = User.find_by(auth_token: params[:id])
		user.generate_authentication_token
		user.save
		head 204		
	end

	private
		def user_downcase
			params[:session][:email] = params[:session][:email].downcase			
		end
end
