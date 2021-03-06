require 'rails_helper'

RSpec.describe Api::V1::StoresController, type: :controller do
	before(:each) { request.headers['Accept'] = "application/vnd.demo.v1" }

	# Index action
	describe "GET #index" do
		before(:each) do
			@user = FactoryGirl.create :user, admin: true
			4.times { FactoryGirl.create :store, open_time: open_time, user_id: @user.id }
		end

		#json response
		context "json response" do
			before(:each) do
				get :index, format: :json
			end

			it "returns 4 records from the database" do
				response = json_response[:stores].count
				expect(response).to eql 4
			end

			it "returns all store into a hash" do
				json_response[:stores].each do |json_response|
					expect(json_response).to be_present
				end
			end

			it { should respond_with 200 }
		end

		# html response
		context "html response" do
			before(:each) do
				get :index, format: :html
			end

			it "returns all store into a hash" do
				expect(assigns(:stores).count).to eql 4
			end

			it "renders the index view template" do
				expect(response).to render_template("index")
			end
		end
	end

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
		# Successfully create new store
		context "with valid attributes" do
			before(:each) do
				@user = FactoryGirl.create :user, admin: true
				request.headers["Authorization"] = @user.auth_token
				@store_attributes = FactoryGirl.attributes_for :store, open_time: open_time, user_id: @user.id
			end

			#JSON
			context "json response" do
				before(:each) do
					post :create, {user_id: @user.id, store: @store_attributes, format: :json}
				end

				it "renders the json representation for the store record just created" do
					expect(json_response[:store][:name]).to eql @store_attributes[:name]
				end

				it { should respond_with 201 }
			end

			# HTML
			context "html response" do

				it "saves the new store in the database" do
					expect{ post :create, {user_id: @user.id, store: @store_attributes, format: :html}}.to change(Store, :count).by(1)
				end

				it "redirects to the new store" do
					post :create, { user_id: @user.id, store: @store_attributes, format: :html }
					expect(response).to redirect_to action: :show, id: assigns(:store).id
				end
			end
		end

		# Unsuccessfully create new store
		context "with invalid attributes" do
			before(:each) do
				@user = FactoryGirl.create :user, admin: true
				request.headers["Authorization"] = @user.auth_token
				@invalid_store_attributes = FactoryGirl.attributes_for :store, user_id: @user.id
			end
			#JSON
			context "json response" do
				before(:each) do
					post :create, { user_id: @user.id, store: @invalid_store_attributes, format: :json }
				end

				it "render an errors json" do
					expect(json_response).to have_key(:errors)
				end

				it "renders the json errors full messages" do
					expect(json_response[:errors][:open_time]).to include("can't be blank")
				end
			end

			#HTML
			context "html response" do
				before(:each) do
					@user = FactoryGirl.create :user, admin: true
					@invalid_store_attributes = FactoryGirl.attributes_for :store, user_id: @user.id
				end

				it "does not save the new store" do
					expect{ post :create, { user_id: @user.id, store: @invalid_store_attributes, format: :html } }.to change(Store, :count).by(0)
				end

				it "re-renders the new method" do
					post :create, { user_id: @user.id, store: @invalid_store_attributes, format: :html }
					expect(response).to render_template("new")
				end
			end
		end
	end


	# Update action
	describe "PATCH/PUT #update" do
		before(:each) do
			@user = FactoryGirl.create :user, admin: true
			request.headers["Authorization"] = @user.auth_token
			@store = FactoryGirl.create :store, open_time: open_time, user_id: @user.id
		end

		# Valid attributes
		context "with vaild attributes" do
			#json response
			context "json response" do
				before(:each) do
					put :update, { user_id: @user.id, id: @store.id, store: { name: "New json attributes" }, format: :json }
				end

				it "@store updated successfully with new attributes" do
					expect(json_response[:store][:name]).to eql "New json attributes"
				end

				it { should respond_with 200 }
			end

			# html response
			context "html response" do
				before(:each) do
					put :update, { user_id: @user.id, id: @store.id, store: { name: "New html attributes" }, format: :html }
				end

				it "changes @store's attributes and redirects to updated store" do
					@store.reload
					expect(assigns(:store).name).to eql "New html attributes"
					expect(response).to redirect_to action: :show, id: @store.id
				end

			end
		end

		# Invalid attributes
		context "with invalid attributes" do
			
			# json response
			context "json response" do
				before(:each) do
					put :update, { user_id: @user.id, id: @store.id, store: { open_time: "invalid attributes" }, format: :json }
				end

				it "renders an errors json key" do
					expect(json_response).to have_key(:errors)
				end

				it "renders the json errors full messages" do
					expect(json_response[:errors][:open_time]).to include "can't be blank"
				end

				it { should respond_with 422 }
			end

			# html response
			context "html response" do
				before(:each) do
					put :update, { user_id: @user.id, id: @store.id, store: { open_time: "invalid attributes" }, format: :html }
				end

				it "does not change @store's attributes and re-renders the edit action" do
					@store.reload
					expect(@store.open_time).not_to match("invalid attributes")
					expect(response).to render_template("edit")
				end
			end
		end
	end

	# Destroy action
	describe "DELETE #destroy" do
		before(:each) do
			@user = FactoryGirl.create :user, admin: true
			request.headers["Authorization"] = @user.auth_token
			@store = FactoryGirl.create :store, open_time: open_time, user_id: @user.id
		end

		# json response
		context "json resonse" do
			before(:each) do
				delete :destroy, id: @store.id, format: :json
			end

			it { should respond_with 204 }
		end

		# html response
		context "html response" do
			it "deletes the store" do
				expect{ delete :destroy, id: @store.id, format: :html }.to change(Store, :count).by(-1)
			end

			it "redirects to home page" do
				delete :destroy, id: @store, format: :html
				expect(response).to redirect_to root_path
			end
		end
	end
end
