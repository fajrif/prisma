class ApplicationMailer < ActionMailer::Base
	default from: configatron.no_reply_email
  layout "mailer"
end
