class ContentBlock < ApplicationRecord
	# Template snippet yang boleh dipasang lewat panel "Blok konten" di admin.
	TEMPLATES = %w[faq table].freeze

	default_scope { order(order_no: :asc, id: :asc) }

	belongs_to :placeable, polymorphic: true
	belongs_to :snippet

	scope :visible, -> { where(hidden: 0) }

	def is_hidden?
		hidden == 1
	end
end
