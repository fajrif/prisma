# Blok snippet (FAQ, tabel) yang dipasang pada sebuah konten lewat panel "Blok konten"
# (admins/shared/_content_blocks_panel) dan dirender oleh shared/_content_blocks.
module HasContentBlocks
	extend ActiveSupport::Concern

	included do
		has_many :content_blocks, as: :placeable, dependent: :destroy
		accepts_nested_attributes_for :content_blocks, allow_destroy: true, reject_if: ->(attrs) { attrs['snippet_id'].blank? }
	end

	# Parameter admin: `permit(..., content_blocks_attributes: HasContentBlocks::PERMITTED)`
	PERMITTED = %i[id snippet_id order_no hidden _destroy].freeze
end
