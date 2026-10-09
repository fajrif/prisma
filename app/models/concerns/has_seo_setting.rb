# Menghubungkan sebuah konten dengan data SEO tambahan (meta & social share).
# Dibaca lewat SeoMeta (rantai fallback) dan diisi dari panel "SEO & Social" di admin
# (admins/shared/_seo_panel) lewat nested attributes.
module HasSeoSetting
	extend ActiveSupport::Concern

	SEO_ATTRIBUTES = %i[meta_title meta_description og_title og_description og_image
											og_type twitter_card robots canonical_override].freeze

	included do
		has_one :seo_setting, as: :seoable, dependent: :destroy

		# update_only: satu record per konten, dan form tidak perlu mengirim id.
		# Panel yang dibiarkan kosong tidak membuat baris baru di tabel.
		accepts_nested_attributes_for :seo_setting, update_only: true, reject_if: :seo_attributes_blank?
	end

	# Parameter yang diizinkan di controller admin: `permit(..., seo_setting_attributes: HasSeoSetting::PERMITTED)`
	PERMITTED = (SEO_ATTRIBUTES + [:id]).freeze

	def seo
		seo_setting || build_seo_setting
	end

	def schema_markups
		SchemaMarkup.where(schemable_type: self.class.name, schemable_id: id)
	end

	private

	def seo_attributes_blank?(attributes)
		attributes.except('id', '_destroy').values.all?(&:blank?)
	end
end
