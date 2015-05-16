require 'rails_helper'

RSpec.describe Api::V1::StoresController, type: :controller do
	before(:each) { request.headers['Accept'] = "application/vnd.demo.v1" }

	# Show action
	describe "GET #show" do
		before(:each) do
			@store = FactoryGirl.create :store
		end

		context "json response" do
			before(:each) do
				get :show, id: @store, format: :json
			end

			it "returns the information about store" do
				store_repsonse = json_response
				expect(store_repsonse[:name]).to eql @store.name
			end
			
			it { should respond_with 200 }
		end

		context "html response" do
			before(:each) do
				get :show, id: @store.id, format: :html
			end

			it "responds successfully with an HTTP 200 status code" do
				expect(response).to be_success
				expect(response).to have_http_status(200)
			end

			it "renders the show template" do
				expect(response).to render_template("show")
			end
		end
	end
end
