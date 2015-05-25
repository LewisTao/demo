class Category < ActiveRecord::Base
	validates_presence_of :name

	has_many :stores, dependent: :destroy
end
