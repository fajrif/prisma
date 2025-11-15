class Inquiry < ApplicationRecord

	default_scope { order(created_at: :desc) }

	attr_accessor :use_v2

  # Validations
  validates_presence_of :name, :email, :company_name, :phone, :message
	validates :email, email: true
	validates :message, length: { maximum: 250 }

  after_commit :send_notification_email

  def send_notification_email
    begin
      SystemMailer.new.inquiry_notification(self.id, "Inquiry - #{self.name}")
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    end
  end

end
