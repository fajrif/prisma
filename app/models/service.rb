class Service < ApplicationRecord
	extend Mobility
  translates :name, :caption, :short_description, :description, :benefit_title, :benefit_description

	extend FriendlyId
  friendly_id :name, use: :slugged

	has_one_attached :image, dependent: :purge
  has_many :benefits
	belongs_to :banner_section, optional: true

	has_many :segments, dependent: :destroy
  has_many :snippets, through: :segments

	validates_presence_of :name, :caption, :short_description, :description, :color
	validates_uniqueness_of :name

	validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }

	def should_generate_new_friendly_id?
		self.name_changed?
	end
end
