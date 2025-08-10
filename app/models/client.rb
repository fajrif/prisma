class Client < ApplicationRecord

	validates_presence_of :company_name
  has_one_attached :image

	validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
end
