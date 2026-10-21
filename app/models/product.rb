class Product < ApplicationRecord
	include ContentModified
	extend Mobility
  translates :description

	extend FriendlyId
  friendly_id :name, use: :slugged

	include HasSeoSetting
	include HasContentBlocks

  default_scope { order(created_at: :desc) }

  # Billboard types: 0 = Digital Billboard, 1 = Static Billboard
  enum :billboard_type, { digital: 0, static: 1 }, default: :digital

	IMAGE_ATTACHMENTS = %w[image image1 image2 banner].freeze

	has_one_attached :banner, dependent: :purge
	has_one_attached :image, dependent: :purge
	has_one_attached :image1, dependent: :purge
	has_one_attached :image2, dependent: :purge
  belongs_to :location
  belongs_to :area
  belongs_to :sub_area, optional: true
  belongs_to :product_category

	validates_presence_of :name, :address, :longitude, :latitude
	validate :sub_area_belongs_to_area

	# Location selalu mengikuti area-nya; kolom location_id dipertahankan untuk query lama.
	before_validation { self.location_id = area.location_id if area }
	validates_uniqueness_of :name

	validates :image, attached: true, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg', 'image/webp'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
	validates :image1, attached: true, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg', 'image/webp'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
	validates :image2, attached: true, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg', 'image/webp'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
	validates :banner, attached: true, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg', 'image/webp'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }

	def should_generate_new_friendly_id?
		self.name_changed?
	end

	# Ditampilkan latitude dulu, mengikuti konvensi umum peta. Sebelumnya longitude
	# yang ditulis lebih dulu, sehingga "106.99, -6.24" terbaca seperti koordinat terbalik.
	def map_coordinate
		"#{self.latitude}, #{self.longitude}"
	end

  # Variant 500x500 untuk info window peta lokasi (WebP bila server mendukung).
  # LIST_THUMB_SIZE: thumbnail daftar lokasi (tampil ±75px, cukup tajam di layar 3x).
  LIST_THUMB_SIZE = 240

  def image_thumb_variant(size = 500)
    return unless image.attached?

    opts = { resize_to_limit: [size, size], saver: { strip: true, quality: 80 } }
    opts[:format] = :webp if PerformanceHelper.webp?
    image.variant(opts)
  end

  def image_url_thumb(size = 500)
    variant = image_thumb_variant(size)
    Rails.application.routes.url_helpers.url_for(variant) if variant
  end

  def billboard_type_label
    billboard_type == "digital" ? "Digital Billboard" : "Static Billboard"
  end

  # Label tipe sesuai bahasa halaman ("Static Billboard", "Billboard Statis", ...).
  def type_name
    I18n.t("seo.billboard_type.#{billboard_type}", default: billboard_type_label)
  end

  # Orientasi diturunkan dari nama kategori produk ("Horizontal LED", "Vertical Static
  # Billboard", "Curved Horizontal LED", ...). Dipakai subtitle dan schema Place.
  def orientation
    category = product_category&.name.to_s
    match = category.match(/\b(curved\s+)?(horizontal|vertical|square)\b/i)
    match && match[0].split.map(&:capitalize).join(' ')
  end

  # Kalimat ringkas di bawah H1, juga `description` schema Place (spec bagian 4), mis.
  # "Billboard statis horizontal di Jl. Ahmad Yani, Bekasi, dengan estimasi 133.376 impresi per hari."
  def subtitle
    # Huruf kecil di tengah frasa ("Billboard statis horizontal"); Mandarin tidak berhuruf kapital.
    latin = I18n.locale.to_sym != :cn
    type = latin ? type_name.downcase : type_name
    type = I18n.t('products.type_with_orientation', type: type, orientation: orientation.downcase) if orientation
    type = type.upcase_first

    street = address.to_s.split(',').first.to_s.squish
    place = [street.presence, (city if city.present? && !street.include?(city.to_s))].compact.join(', ')
    place = city.to_s if place.blank?

    if impressions_per_day.to_i.positive?
      I18n.t('products.subtitle', type: type, place: place, count: impressions_text)
    else
      I18n.t('products.subtitle_short', type: type, place: place)
    end
  end

  # Pemisah ribuan mengikuti bahasa: titik di Indonesia ("46.694"), koma di bahasa lain.
  def impressions_text
    delimiter = I18n.locale.to_sym == :id ? '.' : ','
    ActiveSupport::NumberHelper.number_to_delimited(impressions_per_day, delimiter: delimiter)
  end

  # Titik lain di area yang sama untuk section "Billboard lain di {area}", urutan sama dengan
  # daftar di halaman area. Kosong bila titik ini satu-satunya di areanya (section tidak dirender).
  def related_sites
    others = area ? area.ordered_products.where.not(id: id).to_a : []
    [others, area]
  end

  # URL halaman billboard: /billboards/{slug} (satu sumber untuk sitemap, schema, peta, admin,
  # redirect). Datar supaya tidak berubah saat area diganti nama/dikelompokkan ulang (keputusan
  # 2026-10-19); hierarki lokasi › area tetap tampil lewat breadcrumb.
  def public_path(locale = I18n.locale)
    "#{PublicPath.prefix(locale)}/billboards/#{slug}"
  end

  # Dipakai info window peta (locations.js); path relatif agar ikut host yang sedang dibuka.
  def product_url_path
    public_path
  end

  private

  # Sub area harus milik area titik ini; kalau area diganti, sub area lama tidak boleh terbawa.
  def sub_area_belongs_to_area
    return if sub_area.blank? || sub_area.area_id == area_id

    errors.add(:sub_area, 'bukan bagian dari area yang dipilih')
  end
end

