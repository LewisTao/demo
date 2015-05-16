class Store < ActiveRecord::Base
	# Convert text to array
	attr_accessor :day1, :day2
	serialize :open_time, Hash


	# Validates
	validates_presence_of :name, :description, :address, :open_time

	
end
