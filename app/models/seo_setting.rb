class SeoSetting < ApplicationRecord
	extend Mobility
	translates :meta_title, :meta_description, :og_title, :og_description

	belongs_to :seoable, polymorphic: true

	has_one_attached :og_image, dependent: :purge

	validates :og_image, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/webp'],
											size: { less_than: 10.megabytes, message: 'Image maximum 10MB' }

	def og_image_url
		return unless og_image.attached?

		Rails.application.routes.url_helpers.url_for(og_image)
	end
end
