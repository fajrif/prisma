class Portfolio < ApplicationRecord
	extend Mobility
  translates :name, :description

	include QuilleditorExtension

	has_one_attached :image, dependent: :purge
	belongs_to :page, optional: true

	validates_presence_of :name, :company_name, :description
	validates_uniqueness_of :name

	validates :image, attached: true, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }

	def complete_name
		"#{self.name} (#{self.company_name})"
	end
end
