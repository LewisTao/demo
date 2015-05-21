class Store < ActiveRecord::Base
	# before filter
	before_save :serialize_to_hash
	
	belongs_to :user

	# Convert text to array
	attr_accessor :day1, :day2
	serialize :open_time, Hash


	# Validates
	validates_presence_of :name, :description, :address, :open_time

	# Image upload
	has_attached_file :image, styles: { :medium => "300x300>", :thumb => "100x100>", :HD => "720x1280>" }
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	
  	# New method
	def serialize_to_hash
	  self.open_time = self.open_time.to_hash
	end
end
