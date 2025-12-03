class BoostadService < ApplicationRecord
	extend Mobility
  translates :title, :description

	default_scope { order(id: :asc) }

	has_one_attached :image, dependent: :purge

  validates_presence_of :title, :description, :image
	validates_uniqueness_of :title
	validates :image, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg', 'image/webp'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }

  def name
    self.title
  end
end
