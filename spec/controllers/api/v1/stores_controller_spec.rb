require 'rails_helper'

RSpec.describe Api::V1::StoresController, type: :controller do
	before(:each) { request.headers['Accept'] = "application/vnd.demo.v1" }

	# Show action
	describe "GET #show" do
		before(:each) do
			@store = FactoryGirl.create :store, open_time: open_time
		end

		# JSON
		context "json response" do
			before(:each) do
				get :show, id: @store, format: :json
			end

			it "returns the information about store in a hash" do
				store_response = json_response[:store]
				expect(store_response[:name]).to eql @store.name
			end
			
			it { should respond_with 200 }
		end

		# HTML
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

	# Create action
	describe "POST #create" do
		context "when is successfully created" do
			before(:each) do
				@store_attributes = FactoryGirl.attributes_for :store, open_time: open_time
			end

			#JSON
			context "json response" do
				before(:each) do
					post :create, store: @store_attributes, format: :json
				end

				it "renders the json representation for the store record just created" do
					store_response = json_response[:store]
					expect(json_response[:store][:name]).to eql @store_attributes[:name]
				end

				it { should respond_with 201 }
			end

			# HTML
			context "html response" do
				before(:each) do
					post :create, store: @store_attributes, format: :html
				end
			end
		end
	end
end
