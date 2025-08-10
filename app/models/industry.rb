class Industry < ApplicationRecord
	extend Mobility
  translates :name, :caption, :description

	include QuilleditorExtension

	extend FriendlyId
  friendly_id :name, use: :slugged

	has_one_attached :image, dependent: :purge
	belongs_to :banner_section, optional: true

	validates_presence_of :name, :caption, :description
	validates_uniqueness_of :name

	validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }

	def should_generate_new_friendly_id?
		self.name_changed?
	end
end
