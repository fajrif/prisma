# Area di dalam hub lokasi (mis. Jakarta Pusat di Jakarta). Tidak punya halaman sendiri:
# tampil sebagai section H2 (id = slug) di hub /locations/{location}#{slug}; URL lama
# /locations/{location}/{area} di-301 ke sana (AreasController).
#
# Nama diterjemahkan (ID = nama lokal, EN mengikuti sheet SEO 19 Oct: "Central Jakarta", ...;
# CN jatuh ke EN); slug URL dibentuk dari nama ID (nama lokal) dan hanya berubah bila nama ID
# diganti, jadi menyunting terjemahan EN/CN tidak memindahkan URL.
class Area < ApplicationRecord
	include ContentModified
	extend Mobility
	translates :name
	translates :description
	translates :hub_title

	extend FriendlyId
	friendly_id :slug_source, use: :scoped, scope: :location

	include HasContentBlocks

	default_scope { order(:position, :id) }

	belongs_to :location
	belongs_to :banner_section, optional: true
	has_many :products, dependent: :restrict_with_error
	has_many :sub_areas, -> { order(:position, :id) }, dependent: :restrict_with_error

	validates :name, presence: true
	validate :uniqueness_of_name_within_location

	# Sumber slug: nama ID (bahasa asli area), bukan bahasa yang sedang diedit.
	def slug_source
		Mobility.with_locale(:id) { name(fallback: false) }.presence || name
	end

	def should_generate_new_friendly_id?
		slug.blank? || id_name_changed?
	end

	# Link ke section area di hub (satu sumber untuk breadcrumb produk, tombol "view all",
	# admin, dan redirect halaman area lama).
	# Location dengan satu area (Bandung, Bali) tidak punya section area, jadi tanpa anchor.
	def public_path(locale = I18n.locale)
		location.areas.size > 1 ? "#{location.public_path(locale)}##{slug}" : location.public_path(locale)
	end

	# Judul H2 section di hub: override per bahasa bila diisi, kalau tidak "Billboard di {area}".
	def section_title
		hub_title.presence || I18n.t('locations.area_title', area: name)
	end

	# Titik berkoordinat di area ini, urut impresi/hari lalu nama (urutan yang sama dengan
	# Location#ordered_products, sesuai sheet SEO 19 Oct). Dipakai daftar kiri, peta,
	# ItemList schema, dan section "Billboard lain di {area}".
	def ordered_products(type = nil)
		scope = products.includes(:location, :area).where.not(latitude: nil, longitude: nil)
										.reorder(Arel.sql('products.impressions_per_day DESC NULLS LAST, products.name ASC'))
		Product.billboard_types.key?(type.to_s) ? scope.where(billboard_type: type) : scope
	end

	# Daftar titik dikelompokkan per sub_area untuk halaman area: [sub_area, titik] mengikuti
	# urutan sub_area (position), grup kosong saat filter tipe aktif dilepas, lalu titik tanpa
	# sub_area sebagai grup terakhir (fallback sheet SEO 19 Oct). Urutan dalam grup = ordered_products.
	def grouped_products(type = nil)
		scope = ordered_products(type).includes(:sub_area).to_a
		sub_areas_list = sub_areas.to_a
		used_ids = sub_areas_list.map(&:id)

		groups = sub_areas_list.map { |sub_area| [sub_area, scope.select { |p| p.sub_area_id == sub_area.id }] }
		groups = groups.reject { |_, titik| titik.empty? }
		rest = scope.reject { |p| used_ids.include?(p.sub_area_id) }
		groups << [nil, rest] if rest.any?
		groups
	end

	private

	# Keunikan nama per location mencakup semua bahasa (index unique dilepas saat kolom
	# name menjadi jsonb); cukup di sini karena jumlah area sedikit.
	def uniqueness_of_name_within_location
		mine = translated_name_values
		return if mine.empty?

		Area.where(location_id: location_id).where.not(id: id).find_each do |other|
			if (mine & other.translated_name_values).any?
				errors.add(:name, :taken)
				break
			end
		end
	end

	protected

	# Semua nilai nama pada tiap bahasa (tanpa fallback), dinormalisasi untuk perbandingan.
	def translated_name_values
		Mobility.available_locales.filter_map do |locale|
			Mobility.with_locale(locale) { name(fallback: false).to_s.strip.downcase.presence }
		end.uniq
	end

	def id_name_changed?
		(attribute_in_database('name') || {})['id'].to_s != Mobility.with_locale(:id) { name(fallback: false).to_s }
	end

	# Halaman area menampilkan daftar billboard, jadi ikut berubah bila billboard-nya berubah.
	def related_modified_at
		[products.unscope(:order).maximum(:updated_at)]
	end
end
