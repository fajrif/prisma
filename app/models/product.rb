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
  belongs_to :product_category

	validates_presence_of :name, :address, :longitude, :latitude
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

  def image_url_thumb
    return unless image.attached?

    Rails.application.routes.url_helpers.url_for(image.variant(resize_to_limit: [500, 500]))
  end

  def billboard_type_label
    billboard_type == "digital" ? "Digital Billboard" : "Static Billboard"
  end

  def product_url_path
    options = { host: Rails.application.routes.default_url_options[:host] }
    # only include locale if it's not default
    options[:locale] = I18n.locale == I18n.default_locale ? nil : I18n.locale

    Rails.application.routes.url_helpers.polymorphic_url(self, options)
  end
end

