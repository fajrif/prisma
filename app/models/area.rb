# Area di dalam hub lokasi (mis. Jakarta Pusat di Jakarta). Tingkat ketiga URL billboard:
# /locations/{location}/{area}/{product}, dan punya halaman sendiri /locations/{location}/{area}.
#
# Nama tidak diterjemahkan (nama lokal, sama di semua bahasa); slug-nya unik per location.
class Area < ApplicationRecord
	include ContentModified
	extend Mobility
	translates :description

	extend FriendlyId
	friendly_id :name, use: :scoped, scope: :location

	include HasSeoSetting
	include HasContentBlocks

	default_scope { order(:position, :id) }

	belongs_to :location
	belongs_to :banner_section, optional: true
	has_many :products, dependent: :restrict_with_error

	validates :name, presence: true, uniqueness: { scope: :location_id }

	def should_generate_new_friendly_id?
		name_changed? || slug.blank?
	end

	# Banner sendiri bila diisi; kalau tidak, banner hub-nya.
	def effective_banner_section
		banner_section || location&.banner_section
	end

	def own_banner?
		banner_section.present?
	end

	# Location dengan satu area saja (Bandung, Bali): halaman area isinya sama dengan hub,
	# jadi tidak ditampilkan sebagai pill, canonical ke hub, dan tidak masuk sitemap.
	def standalone?
		location.areas.size > 1
	end

	def public_path(locale = I18n.locale)
		"#{PublicPath.prefix(locale)}/locations/#{location.slug}/#{slug}"
	end

	private

	# Halaman area menampilkan daftar billboard, jadi ikut berubah bila billboard-nya berubah.
	def related_modified_at
		[products.unscope(:order).maximum(:updated_at)]
	end
end
