class Member < ApplicationRecord
	extend Mobility
  translates :job_title, :description

	include QuilleditorExtension

	default_scope { order(order_no: :asc) }

	has_one_attached :photo, dependent: :purge
	belongs_to :member_type

	validates :photo, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
										size: { less_than: 10.megabytes, message: 'Image maximum 10MB' }
	validates_presence_of :full_name, :job_title

	before_validation :init_order_no

	def init_order_no
		if self.member_type and self.order_no.zero?
			_size = self.member_type.members.size
			_size += 1
			self.order_no = _size
		end
	end
end
