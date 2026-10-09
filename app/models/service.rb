class Service < ApplicationRecord
	extend Mobility
  translates :name, :caption, :short_description, :description, :benefit_title, :benefit_description, :meta_title, :meta_description

	extend FriendlyId
  friendly_id :name, use: :slugged

	include HasSeoSetting

	default_scope { order(id: :asc) }

	has_one_attached :image, dependent: :purge
	has_one_attached :image_white, dependent: :purge
	has_one_attached :image1, dependent: :purge
  has_many :benefits
	belongs_to :banner_section, optional: true

	has_many :segments, dependent: :destroy
  has_many :snippets, through: :segments

	validates_presence_of :name, :caption, :short_description, :description, :color
	validates_uniqueness_of :name

	validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/webp'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
	validates :image_white, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/webp'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
	validates :image1, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/webp'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }

	def should_generate_new_friendly_id?
		self.name_changed?
	end

	# Tipe yang diterima schema.org untuk areaServed. Nilai lain ditolak supaya typo
	# tidak menghasilkan @type yang tidak dikenal.
	AREA_TYPES = %w[City AdministrativeArea State Country].freeze

	# area_served disimpan sebagai array JSON [{type, name}]. Di form diedit sebagai
	# teks, satu area per baris dengan format "Tipe: Nama", mis. "City: Jakarta".
	def area_served_text
		Array(area_served).map { |a| "#{a['type']}: #{a['name']}" }.join("\n")
	end

	def area_served_text=(text)
		self.area_served = text.to_s.lines.map(&:strip).reject(&:blank?).map do |line|
			type, name = line.split(':', 2).map(&:strip)
			{ 'type' => type, 'name' => name }
		end
	end

	validate :area_served_must_be_valid

	private

	def area_served_must_be_valid
		Array(area_served).each do |area|
			next if AREA_TYPES.include?(area['type']) && area['name'].present?

			errors.add(:area_served_text, "baris tidak valid: \"#{area['type']}: #{area['name']}\". " \
										"Gunakan format \"Tipe: Nama\" dengan tipe #{AREA_TYPES.join(', ')}")
		end
	end

	public

  def self.get_service_glance
    # Assume you have a Post model and a list of desired IDs
    desired_order_ids = [4, 1, 6, 2, 5, 3]

    # Build the CASE statement for ordering
    order_clause = "CASE id "
    desired_order_ids.each_with_index do |id, index|
      order_clause << "WHEN #{id} THEN #{index} "
    end
    order_clause << "END"

    # Fetch the records and apply the custom order
    services = Service.unscoped.where(id: desired_order_ids).order(Arel.sql(order_clause))
  end
end
