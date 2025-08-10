class Career < ApplicationRecord
	extend Mobility
  translates :short_description

	extend FriendlyId
  friendly_id :title, use: :slugged

	include PublishedExtension

	translates :content, backend: :action_text

	default_scope { order(published_date: :desc) }

	has_one_attached :file, dependent: :purge
	has_one :action_text_rich_text, class_name: 'ActionText::RichText', as: :record

	# => File
	validates :file, content_type: ['application/pdf', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/msword'],
										size: { less_than: 50.megabytes, message: 'File maximum 50MB' }

  validates_presence_of :title, :location, :company_name
	validates_uniqueness_of :title

	def should_generate_new_friendly_id?
		self.title_changed?
	end

end
