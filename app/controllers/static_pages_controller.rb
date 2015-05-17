class StaticPagesController < ApplicationController
	def home_page
		@stores = Store.all
	end

	def about_page
	end

	def FAQ_page
	end
end
