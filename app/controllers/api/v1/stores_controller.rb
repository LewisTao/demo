class Api::V1::StoresController < ApplicationController
	def show
		store = Store.find(params[:id])
		respond_to do |format|
			format.html
			format.json { render json: store, status: 200, location: [:api, store] } 
		end
	end
end
