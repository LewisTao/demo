class Api::V1::StoresController < ApplicationController

	def show
		@store = Store.find(params[:id])
		respond_to do |format|
			format.html
			format.json { render json: @store, status: 200, location: [:api, @store] } 
		end
	end

	def new
		@store = Store.new
	end

	def create
		@store = Store.create(store_params)

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

	private
		def store_params
			params.require(:store).permit(:name, :description, :address, {:open_time => [:day1, :day2]})
		end

end
