class Portfolio < ApplicationRecord
	extend Mobility
  translates :caption, :short_description, :description, :about_campaign, :area_coverage, :creative_highlights

	extend FriendlyId
  friendly_id :name, use: :slugged

	include QuilleditorExtension

	has_one_attached :logo, dependent: :purge
	has_one_attached :image, dependent: :purge
	has_one_attached :image1, dependent: :purge
	has_one_attached :image2, dependent: :purge
	has_one_attached :banner, dependent: :purge
  belongs_to :service
  belongs_to :industry

	validates_presence_of :name, :company_name, :short_description, :description, :about_campaign, :area_coverage
	validates_uniqueness_of :name

	validates :logo, attached: true, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
	validates :image, attached: true, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
	validates :image1, attached: true, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
	validates :image2, attached: true, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
	validates :banner, attached: true, content_type: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }

  protected

	def should_generate_new_friendly_id?
		self.name_changed?
	end

	def check_description_empty
		if self.has_attribute?(:short_description)
			self.short_description = "" if self.short_description == "<p><br></p>"
		end
		if self.has_attribute?(:about_campaign)
			self.about_campaign = "" if self.about_campaign == "<p><br></p>"
		end
		if self.has_attribute?(:area_coverage)
			self.area_coverage = "" if self.area_coverage == "<p><br></p>"
		end
		if self.has_attribute?(:creative_highlights)
			self.creative_highlights = "" if self.creative_highlights == "<p><br></p>"
		end
		self.description = "" if self.description == "<p><br></p>"
	end

  def featured_label
    self.featured == 1 ? 'Yes' : 'No'
  end

end
