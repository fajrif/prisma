class Location < ApplicationRecord
	extend Mobility
  translates :description

	extend FriendlyId
  friendly_id :name, use: :slugged

	default_scope { order(id: :asc) }

  validates_presence_of :name, :description
	validates_uniqueness_of :name

	has_one_attached :image, dependent: :purge
	has_one_attached :banner, dependent: :purge

  validates :image, attached: true, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg', 'image/webp'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
  validates :banner, attached: true, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg', 'image/webp'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }

	has_many :products
  belongs_to :banner_section

	def should_generate_new_friendly_id?
		self.name_changed?
	end

end
