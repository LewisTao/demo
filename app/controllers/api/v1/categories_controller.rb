class Api::V1::CategoriesController < ApplicationController
	def index
		@categories = Category.all
		respond_to do |format|
			format.html
			format.json { render json: @categories, status: 200 }
		end
	end
end
