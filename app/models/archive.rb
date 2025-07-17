class Archive < ApplicationRecord
	extend Mobility
  translates :title, :short_description

	include PublishedExtension

	default_scope { order(published_date: :desc) }
	scope :get_all_by_archive_type, ->(archive_type_id) { where("archive_type_id = ?", archive_type_id) }

	has_one_attached :file, dependent: :purge
	belongs_to :archive_type

	validates_presence_of :title
	validates_uniqueness_of :title

	# => File
	validates :file, attached: true, content_type: ['application/pdf', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/msword'],
										size: { less_than: 50.megabytes, message: 'File maximum 50MB' }

	def private?
		self.private == 1
	end

	def private_label
		self.private? ? "Private" : "Public"
	end

	def read_only?
		self.read_only == 1
	end

	def read_only_label
		self.read_only? ? "Read-Only" : "Global"
	end
end
