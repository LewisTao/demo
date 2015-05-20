require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
	before(:each) do
		request.headers['Accept'] = "application/vnd.demo.v1"
	end

	# show action
	describe "GET #show" do
		before(:each) do
			@user = FactoryGirl.create :user
		end

		# json response
		context "json response" do
			before(:each) do
				get :show, id: @user.id, format: :json
			end

			it "returns user information in a hash" do
				expect(json_response[:user][:email]).to eql @user.email
			end

			it { should respond_with 200 }
		end

		# html response
		context "html response" do
			before(:each) do
				get :show, id: @user.id, format: :html
			end

			it "returns user information" do
				expect(assigns[:user][:email]).to eql  @user.email
			end

			it "renders the #show view" do
				expect(response).to render_template :show
			end
		end
	end

	# create action
	describe "POST #create" do
		# Successfully created user
		context "valid attributes" do
			before(:each) do
				@user_attributes = FactoryGirl.attributes_for :user
			end

			# json response
			context "json response" do
				before(:each) do
					post :create, user: @user_attributes, format: :json
				end

				it "renders the json representation for the user record just created" do
					expect(json_response[:user][:email]).to eql @user_attributes[:email]
				end

				it { should respond_with 201 }
			end
		end

		# Unsuccessfully created user
		context "invalid attributes" do
			before(:each) do
				@invalid_user_attributes = FactoryGirl.attributes_for :user, email: "invalidemail.com"
			end

			# json response
			context "json response" do
				before(:each) do
					post :create, user: @invalid_user_attributes, format: :json
				end

				it "returns json errors key" do
					expect(json_response).to have_key(:errors)
				end

				it "returns full messages explain why the user could not be created" do
					expect(json_response[:errors][:email]).to include "is invalid"
				end

				it { should respond_with 422 }
			end
		end
	end

	# Update action
	describe "PUT/PATCH #update" do
		before(:each) do
			@user = FactoryGirl.create :user
		end

		# Successfully updated
		context "successfully updated" do
			before(:each) do
				put :update, id: @user.id, user: { email: "email@example.com" }, format: :json
			end

			it "User updated successfully with new attributes" do
				expect(json_response[:user][:email]).to eql "email@example.com"
			end

			it { should respond_with 200 }
		end

		# Unsuccessfully updated
		context "unsuccessfully updated" do
			before(:each) do
				put :update, id: @user.id, user: { email: "invalid_email" }, format: :json
			end

			it "renders json errors key" do
				expect(json_response).to have_key(:errors)
			end

			it "renders the json full messages explain why user can not updated" do
				expect(json_response[:errors][:email]).to include "is invalid"
			end

			it { should respond_with 422 }
		end
	end

	# destroy action
	describe "DELETE #destroy" do
		before(:each) do
			@user = FactoryGirl.create :user
			delete :destroy, id: @user.id, format: :json
		end

		it { should respond_with 204 }
	end
end
