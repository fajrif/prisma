class Page < ApplicationRecord
	include ContentModified
	extend Mobility
  # meta title/description kini di seo_settings (HasSeoSetting); kolom lama dibiarkan di DB.

	extend FriendlyId
  friendly_id :title, use: :slugged

	include PublishedExtension
	include HasSeoSetting

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

	private

	# Isi Page disusun dari section -> snippet (tabel `sections` tidak punya timestamp)
	# dan rich text `content` per bahasa.
	def related_modified_at
		[snippets.maximum(:updated_at),
		 ActionText::RichText.where(record_type: 'Page', record_id: id).maximum(:updated_at)]
	end
end
