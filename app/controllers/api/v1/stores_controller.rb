class Api::V1::StoresController < ApplicationController
	# before filter
	before_action :set_store, except: [:index, :new, :create]
	before_action :authenticate_with_token!, except: [:index, :show]
	before_action :check_admin, except: [:index, :show]
	before_action :check_correct_user, only: [:edit, :update, :destroy]

	def index
		@stores = Store.all.order("created_at DESC")
		respond_to do |format|
			format.html
			format.json { render json: @stores, status: 200 }
		end
	end
	
	def show
		respond_to do |format|
			format.html
			format.json { render json: @store, status: 200, location: [:api, @store] } 
		end
	end

	def new
		@store = current_user.stores.new
	end

	def create
		@user = User.find(params[:user_id])
		@store = @user.stores.build(store_params)

		respond_to do |format|
			if @store.save
				format.html { redirect_to api_store_path(@store) , success: "Successfully created!" }
				format.json { render json: @store, status: 201, location: [:api, @store] }
			else
				format.html { render "new" }
				format.json { render json: { errors: @store.errors }, status: 422 }
			end
		end
	end

	def edit
	end

	def update
		respond_to do |format|
			if @store.update(store_params)
				format.html { redirect_to api_store_path(@store), success: "Successfully updated!" }
				format.json { render json: @store, status: 200, location: [:api, @store] }
			else
				format.html { render "edit" }
				format.json { render json: { errors: @store.errors }, status: 422 }
			end
		end
	end

	def destroy
		@store.destroy

		respond_to do |format|
			format.html { redirect_to root_path, success: "Successfully deleted!" }
			format.json { head 204 }
		end
	end


	private

		def check_admin
			render json: { errors: "Access denied! Please login with admin account" } unless current_user.admin?
		end

		def check_correct_user
			redirect_to :back unless @store.user = current_user
		end

		def set_store
			@store = Store.find(params[:id])		
		end

		def store_params
			params.require(:store).permit(:name, :description, :address, {:open_time => [:day1, :day2]}, :image)
		end

end
