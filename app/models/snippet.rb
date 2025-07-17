class Snippet < ApplicationRecord
	extend Mobility
  translates :title, :caption, :short_description, :description

	include QuilleditorExtension

	validates_presence_of :name
	validates_uniqueness_of :name

	has_one_attached :image, dependent: :purge
	has_one_attached :background, dependent: :purge
	has_many :sections, dependent: :destroy
  has_many :pages, through: :sections
	has_many :link_buttons, as: :linkable

	validates :image, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
	validates :background, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }

	acts_as_tree order: :id

	def name_id_label
		"#{self.name} [ID:#{self.id.to_s}]"
	end

	def has_link_button?
		!self.link_buttons.empty?
	end

end
