class Section < ApplicationRecord

	default_scope { order(order_no: :asc) }

	belongs_to :page
	belongs_to :snippet

	before_validation :init_order_no

	def init_order_no
		self.order_no = self.page.sections.size + 1 if self.order_no.zero?
	end

	def is_hidden?
		self.hidden == 1
	end
end
