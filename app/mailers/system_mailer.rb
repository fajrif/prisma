class SystemMailer < ApplicationMailer

	def user_inquiry_notification(email, subject)
		begin
			mail(:to => email, :subject => subject, :template_path => 'system_mailer', :template_name => 'user_inquiry_notification')
		rescue Exception => e
			puts e.message
			puts e.backtrace.inspect
		end
	end

	def inquiry_notification(inquiry_id, email, subject)
		begin
			@inquiry = Inquiry.find(inquiry_id)
			mail(:to => email, :subject => subject, :template_path => 'system_mailer', :template_name => 'email_notification')
		rescue Exception => e
			puts e.message
			puts e.backtrace.inspect
		end
	end

	def application_notification(application_id, email, subject)
		begin
			@application = Application.find(application_id)
			mail(:to => email, :subject => subject, :template_path => 'system_mailer', :template_name => 'application_notification')
		rescue Exception => e
			puts e.message
			puts e.backtrace.inspect
		end
	end

end
