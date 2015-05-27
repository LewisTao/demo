require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
	describe "POST #create" do
		before(:each) do
			@user = FactoryGirl.create :user
		end
		# Successfully created new session
		context "when successfully created new session" do
			before(:each) do
				post :create, session: { email: @user.email, password: "12345678" }, format: :json
			end

			it "returns the user record correct to the given attributes" do
				@user.reload
				expect(json_response[:user][:auth_token]).to eql @user.auth_token
			end

			it { should respond_with 200 }
		end

		# Unsuccessfully created new session
		context "does not created new session" do
			before(:each) do
				post :create, session: { email: @user.email, password: "12345" }, format: :json
			end

			it "renders json errors key" do
				expect(json_response).to have_key(:errors)
			end

			it "renders messages explain why session can not be created" do
				expect(json_response[:errors]).to eql "Invalid email or password"
			end
		end
	end

	# destroy action
	describe "DELETE #destroy" do
		before(:each) do
			@user = FactoryGirl.create :user
			delete :destroy, id: @user.auth_token, format: :json
		end

		it { should respond_with 204 }
	end
end
