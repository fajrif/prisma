class Award < ApplicationRecord
	extend Mobility
  translates :name, :description

	has_one_attached :image, dependent: :purge

	validates_presence_of :name
	validates :image, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg', 'image/webp'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }

end
