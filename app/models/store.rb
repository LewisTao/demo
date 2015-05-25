class Store < ActiveRecord::Base
	# before filter
	before_save :serialize_to_hash
	
	belongs_to :user
	belongs_to :category

	# Convert text to array
	attr_accessor :Mon, :Tue, :Wed, :Thu, :Fri, :Sat, :Sun
	serialize :open_time, Hash


	# Validates
	validates_presence_of :name, :description, :address, :open_time

	# Image upload
	has_attached_file :image, styles: { :medium => "400x350#", :thumb => "100x100#", :HD => "1140x550#" }
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	
  	# New method
	def serialize_to_hash
	  self.open_time = self.open_time.to_hash
	end
end
