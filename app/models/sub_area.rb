# Sub area: neighbourhood di dalam satu area (mis. Sudirman–Thamrin di Jakarta Pusat),
# menjadi judul H3 pada halaman area. `key` ident stabil dari parameterize (tidak berubah
# walau judul diedit); nama & deskripsi diterjemahkan (ID/EN; CN jatuh ke EN).
# Tidak punya halaman sendiri — hanya pengelompok daftar titik.
class SubArea < ApplicationRecord
	extend Mobility
	translates :name
	translates :description

	default_scope { order(:position, :id) }

	belongs_to :area
	has_many :products, dependent: :nullify

	# Key diisi otomatis dari nama (bahasa aktif) bila kosong.
	before_validation { self.key = name.to_s.parameterize if key.blank? && name.present? }

	validates :key, presence: true, uniqueness: { scope: :area_id },
							format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/, message: 'huruf kecil, angka, dan tanda hubung saja' }
	validates :name, presence: true

	# Judul H3 mengikuti bahasa halaman.
	def display_name
		name.presence || key
	end
end
