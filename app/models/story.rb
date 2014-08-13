class Story < ActiveRecord::Base
	# This is like a template for building Story instances
	validates :url, presence: true, uniqueness: true
	validates_format_of :url, with: URI.regexp
	validates :title, presence: true, uniqueness: true

	validates :description,  length: { maximum: 150, minimum: 20}

	has_many :comments

	has_many :votes

end
