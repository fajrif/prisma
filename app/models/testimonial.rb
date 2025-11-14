class Testimonial < ApplicationRecord
	extend Mobility
  translates :message

	validates_presence_of :name, :title, :message, :company_name
  has_one_attached :image

	validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/webp'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
end
