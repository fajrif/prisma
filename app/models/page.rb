class Page < ApplicationRecord
	extend Mobility
  translates :meta_title, :meta_description

	extend FriendlyId
  friendly_id :title, use: :slugged

	include PublishedExtension

	default_scope { order(id: :asc) }

	translates :content, backend: :action_text

	has_many :sections, dependent: :destroy
  has_many :snippets, through: :sections
	belongs_to :banner_section, optional: true

	validates_presence_of :title
	validates_uniqueness_of :title

	def should_generate_new_friendly_id?
		self.title_changed?
	end

	def banners
		self.try(:banner_section).try(:banners)
	end

end
