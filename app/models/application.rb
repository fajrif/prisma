class Application < ApplicationRecord

	attr_accessor :use_v2

  belongs_to :career
	has_one_attached :file, dependent: :purge

	# => File
	validates :file, attached: true, content_type: ['application/pdf', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/msword'],
										size: { less_than: 50.megabytes, message: 'File maximum 50MB' }

  validates_presence_of :name, :email, :phone

	def applied_date_label(use_time=true)
		_format = use_time ? '%d/%m/%Y %H:%M' : '%d/%m/%Y'
		self.try(:created_at).try(:strftime, _format)
	end
end
