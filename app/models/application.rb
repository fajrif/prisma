class Application < ApplicationRecord
	default_scope { order(created_at: :desc) }

	attr_accessor :use_v2

  belongs_to :career
	has_one_attached :file, dependent: :purge

	# => File
	validates :file, attached: true, content_type: ['application/pdf', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/msword'],
										size: { less_than: 20.megabytes, message: 'File maximum 20MB' }

  validates_presence_of :name, :email, :phone

	def applied_date_label(use_time=true)
		_format = use_time ? '%d/%m/%Y %H:%M' : '%d/%m/%Y'
		self.try(:created_at).try(:strftime, _format)
	end

  after_commit :send_notification_email, on: :create

  def send_notification_email
    begin
      return unless file.attached?

      SystemMailer.new.application_notification(self.id, "Application Submission - #{self.name}")
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    end
  end
end
