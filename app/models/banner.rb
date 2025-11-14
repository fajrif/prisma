class Banner < ApplicationRecord
	extend Mobility
  translates :title, :description

	include QuilleditorExtension

	default_scope { order(order_no: :asc) }

	has_one_attached :image, dependent: :purge
	has_one_attached :video, dependent: :purge
	has_many :link_buttons, as: :linkable

	validates :image, attached: true, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg', 'image/webp'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
	validates :video, content_type: ['video/mp4', 'video/webm', 'video/quicktime'],
										size: { less_than: 50.megabytes, message: 'File maximum 50MB' }
	validates_presence_of :title

	belongs_to :banner_section

	def has_link_button?
		!self.link_buttons.empty?
	end

	def is_video?
		self.video.attached?
	end

	def section_id
		return "banner_#{self.banner_section.name.gsub(' ','_').downcase}"
	end

end
