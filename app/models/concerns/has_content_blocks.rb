# Blok snippet (FAQ, tabel) yang dipasang pada sebuah konten lewat tab "Block FAQ" di admin
# (Admins::ContentBlocksController, modal) dan dirender oleh shared/_content_blocks.
module HasContentBlocks
	extend ActiveSupport::Concern

	included do
		has_many :content_blocks, as: :placeable, dependent: :destroy
	end

end
