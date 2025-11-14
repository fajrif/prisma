class Gallery < ApplicationRecord
	extend Mobility
  translates :title, :caption

	default_scope { order(created_at: :desc) }
	scope :photos, -> { where(video_url: "") }
	scope :videos, -> { where.not(video_url: "") }

	has_one_attached :image, dependent: :purge

	validates_presence_of :title
	validates :image, attached: true, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg', 'image/webp'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }

	def is_video?
		!self.video_url.blank?
	end

	def type_label
		self.is_video? ? "Video" : "Photo"
	end

end
