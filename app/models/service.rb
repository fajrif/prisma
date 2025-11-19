class Service < ApplicationRecord
	extend Mobility
  translates :name, :caption, :short_description, :description, :benefit_title, :benefit_description, :meta_title, :meta_description

	extend FriendlyId
  friendly_id :name, use: :slugged

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

  def self.get_service_glance
    # Assume you have a Post model and a list of desired IDs
    desired_order_ids = [1, 4, 2, 6, 5, 3]

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
