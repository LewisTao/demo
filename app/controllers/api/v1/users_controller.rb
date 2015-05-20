class Api::V1::UsersController < ApplicationController

	# before filter
	before_action :authenticate_with_token!, only: [:update, :destroy]
	
	def index
		@users = User.all.order("created_at DESC")
		respond_to do |format|
			format.html
			format.json { render json: @users, status: 200 }
		end		
	end

	def show
		@user = User.find(params[:id])
		respond_to do |format|
			format.html
			format.json { render json: @user, status: 200, location: [:api, @user] }

		end
	end

	def create
		@user = User.create(user_params)
		respond_to do |format|
			if @user.save
				format.json { render json: @user, status: 201, location: [:api, @user] }
			else
				format.json { render json: { errors: @user.errors }, status: 422 }
			end
		end
	end

	def update
		@user = current_user
		respond_to do |format|
			if @user.update(user_params)
				format.json { render json: @user, status: 200, location: [:api, @user] }
			else
				format.json { render json: { errors: @user.errors }, status: 422 }
			end
		end
	end

	def destroy
		
		current_user.destroy
		respond_to do |format|
			format.json { head 204 }
		end
	end

	private
		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation)
		end
end
