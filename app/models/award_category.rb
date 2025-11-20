class AwardCategory < ApplicationRecord
	default_scope { order(id: :asc) }

	has_one_attached :image, dependent: :purge

	validates_presence_of :name
	validates_uniqueness_of :name
	validates :image, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg', 'image/webp'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }

	has_many :awards

end
