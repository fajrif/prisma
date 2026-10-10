class ContentBlock < ApplicationRecord
	# Template snippet yang boleh dipasang lewat panel "Blok konten" di admin.
	TEMPLATES = %w[faq table].freeze

	default_scope { order(order_no: :asc, id: :asc) }

	belongs_to :placeable, polymorphic: true
	belongs_to :snippet

	validates :snippet_id, presence: true
	validates :snippet_id, uniqueness: { scope: %i[placeable_type placeable_id], message: 'sudah terpasang di halaman ini' }
	validate :snippet_template_allowed

	scope :visible, -> { where(hidden: 0) }

	def is_hidden?
		hidden == 1
	end

	private

	def snippet_template_allowed
		return if snippet.blank? || TEMPLATES.include?(snippet.template)

		errors.add(:snippet, "harus bertemplate #{TEMPLATES.join(' atau ')}")
	end
end
