class SystemMailer < ApplicationMailer

	def user_inquiry_notification(email, subject)
		begin
			mail(:to => email, :subject => subject, :template_path => 'system_mailer', :template_name => 'user_inquiry_notification')
		rescue Exception => e
			puts e.message
			puts e.backtrace.inspect
		end
	end

	def investor_inquiry_notification(inquiry_id, email, subject)
		begin
			@inquiry = InvestorInquiry.find(inquiry_id)
			mail(:to => email, :subject => subject, :template_path => 'system_mailer', :template_name => 'investor_email_notification')
		rescue Exception => e
			puts e.message
			puts e.backtrace.inspect
		end
	end

end
