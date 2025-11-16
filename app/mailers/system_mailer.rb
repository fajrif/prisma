class SystemMailer < ApplicationMailer

	#def user_inquiry_notification(email, subject)
		#begin
			#mail(:to => email, :subject => subject, :template_path => 'system_mailer', :template_name => 'user_inquiry_notification')
		#rescue Exception => e
			#puts e.message
			#puts e.backtrace.inspect
		#end
	#end

  def inquiry_notification(inquiry_id, subject)
    if @inquiry = Inquiry.find(inquiry_id)
      # Render the HTML template as a string
      html_content = render_to_string(
        template: 'system_mailer/email_notification',
        layout: 'mailer',
        formats: [:html],
        locals: { inquiry: @inquiry }
      )

     emails = [
        { email: configatron.info_email, name: configatron.email_name },
        { email: configatron.marketing_email, name: configatron.marketing_name }
     ]

      send_email_brevo(subject, emails, html_content)
    end
  rescue Exception => e
    puts e.message
    puts e.backtrace.inspect
  end

  def application_notification(application_id, subject)
    if @application = Application.find(application_id)
      # Render the HTML template as a string
      html_content = render_to_string(
        template: 'system_mailer/application_notification',
        layout: 'mailer',
        formats: [:html],
        locals: { application: @application }
      )

      emails = [
        { email: configatron.hrd_email, name: configatron.hrd_name },
        { email: configatron.marketing_email, name: configatron.marketing_name }
      ]

      send_email_brevo(subject, emails, html_content)
    end
  rescue Exception => e
    puts e.message
    puts e.backtrace.inspect
  end

  protected

  def send_email_brevo(subject, emails, html_content)
    Rails.logger.debug html_content
    Rails.logger.info("BREVO_API_KEY: #{ENV['BREVO_API_KEY']&.slice(0,4)}******")

    sib_api = SibApiV3Sdk::TransactionalEmailsApi.new
    api_key = SibApiV3Sdk.configure.api_key['api-key'] = ENV["BREVO_API_KEY"]

    email = SibApiV3Sdk::SendSmtpEmail.new(
      subject: subject,
      sender: { email: configatron.no_reply_email, name: configatron.email_name },
      to: emails,
      htmlContent: html_content
    )

    sib_api.send_transac_email(email)
  rescue SibApiV3Sdk::ApiError => e
    Rails.logger.error "Brevo API Mail Error: #{e.response_body}"
  end

end
