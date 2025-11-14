class Inquiry < ApplicationRecord

	default_scope { order(created_at: :desc) }

	attr_accessor :use_v2

  # Validations
  validates_presence_of :name, :email, :company_name, :phone, :message
	validates :email, email: true
	validates :message, length: { maximum: 250 }

  after_create :send_notification_email

  def send_notification_email
    receiver = [configatron.info_email, configatron.marketing_email]
               .compact
               .map { |x| x.to_s.split(/[;, ]+/) }
               .flatten
               .uniq
               .join(";")

    return if receiver.blank?

    begin
      SystemMailer.inquiry_notification(self.id, receiver, "#{self.name} [Inquiry]").deliver
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    end
  end

end
