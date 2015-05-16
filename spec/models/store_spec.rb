require 'rails_helper'

RSpec.describe Store, type: :model do
	let(:store) { FactoryGirl.build :store, open_time: open_time }
	subject { store }
	
	# Model attributes
	it { should respond_to :name }
	it { should respond_to :address }
	it { should respond_to :open_time }
	it { should respond_to :description }

	# Model validates
	it { should validate_presence_of :name }
	it { should validate_presence_of :address }
	it { should validate_presence_of :open_time }
	it { should validate_presence_of :description }

	# Convert text to arry attribute
	describe "Convert open time text attribute to array" do
		before(:each) do
			@store = FactoryGirl.create :store, open_time: open_time
		end

		it "Successfully create new store with open time is an array" do
			expect(@store.open_time).to match_array(open_time)
		end
	end
end
	