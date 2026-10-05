# Menghubungkan sebuah konten dengan data SEO tambahan (meta & social share).
# Tabel `seo_settings` disiapkan pada Bulan 1; form admin-nya menyusul pada Bulan 3.
module HasSeoSetting
	extend ActiveSupport::Concern

	included do
		has_one :seo_setting, as: :seoable, dependent: :destroy
	end

	def seo
		seo_setting || build_seo_setting
	end

	def schema_markups
		SchemaMarkup.where(schemable_type: self.class.name, schemable_id: id)
	end
end
