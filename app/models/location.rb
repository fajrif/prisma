class Location < ApplicationRecord
	include ContentModified
	extend Mobility
  translates :description

	extend FriendlyId
  friendly_id :name, use: :slugged

	include HasSeoSetting
	include HasContentBlocks

	default_scope { order(id: :asc) }

  validates_presence_of :name, :description
	validates_uniqueness_of :name

	has_one_attached :image, dependent: :purge
	has_one_attached :banner, dependent: :purge

  validates :image, attached: true, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg', 'image/webp'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
  validates :banner, attached: true, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg', 'image/webp'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }

	has_many :products
	has_many :areas, -> { order(:position, :id) }, dependent: :restrict_with_error
  belongs_to :banner_section

	def should_generate_new_friendly_id?
		self.name_changed?
	end

	def public_path(locale = I18n.locale)
		"#{PublicPath.prefix(locale)}/locations/#{slug}"
	end

	# Titik berkoordinat yang tampil di hub, urut per area (sama dengan urutan pill) lalu nama.
	# Satu sumber untuk daftar kiri, peta, dan ItemList schema, jadi isi dan urutannya selalu sama.
	# `type`: "static"/"digital" untuk filter ?billboard_type=; nilai lain diabaikan.
	def ordered_products(type = nil)
		scope = products.left_outer_joins(:area).includes(:location, :area)
										.where.not(latitude: nil, longitude: nil)
										.reorder(Arel.sql('areas.position ASC NULLS LAST, areas.id ASC, products.name ASC'))
		Product.billboard_types.key?(type.to_s) ? scope.where(billboard_type: type) : scope
	end

	private

	# Halaman hub menampilkan daftar billboard, jadi ikut berubah bila billboard-nya berubah.
	def related_modified_at
		[products.unscope(:order).maximum(:updated_at)]
	end
end
