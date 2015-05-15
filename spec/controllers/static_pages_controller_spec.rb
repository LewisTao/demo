require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
	
	# About page
	describe "GET #about_page" do
		before(:each) do
			get :about_page
		end

		it "responds successfully with an HTTP 200 status code" do
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it "renders the about page template" do
			expect(response).to render_template("about_page")
		end
	end

	# FAQ page
	describe "GET #FAQ_page" do
		before(:each) do
			get :FAQ_page
		end

		it "responds successfully with an HTTP 200 status code" do
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it "renders the FAQ page template" do
			expect(response).to render_template("FAQ_page")
		end
	end
end
