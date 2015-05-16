class Store < ActiveRecord::Base
	# Convert text to array
	serialize :open_time, Array

	# Validates
	validates_presence_of :name, :description, :address, :open_time

	
end
