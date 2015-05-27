class Store < ActiveRecord::Base
	# before filter
	before_save :serialize_to_hash
	
	belongs_to :user
	belongs_to :category

	# Convert text to array
	attr_accessor :Mon, :Tue, :Wed, :Thu, :Fri, :Sat, :Sun, :notice_1, :notice_2, :notice_3
	serialize :open_time, Hash
	serialize :notice, Hash


	# Validates
	validates_presence_of :name, :description, :address

	# Image upload
	has_attached_file :image, styles: { :medium => "453x300#", :thumb => "200x200#", :HD => "1170x550#" }
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	
  	# New method
	def serialize_to_hash
	  self.open_time = self.open_time.to_hash
	  self.notice = self.notice.to_hash
	end
end
