class Store < ActiveRecord::Base
	# Convert text to array
	serialize :open_time, Array

	# Validates
	validates_presence_of :name, :description, :address, :open_time

	# Convert text to arry attribute
	describe "Convert open time text attribute to array" do
		before(:each) do
			@array = [["foo"], ["bar"]]
			@store = FactoryGirl.create :store, open_time: (@array)
		end

		it "Successfully create new store with open time is an array" do
			expect(@store.open_time).to match_array(@array)
		end
	end
end
