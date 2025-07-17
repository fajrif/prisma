class InquiriesController < ApplicationController

  def create
		@success = false
		@inquiry = Inquiry.new(params_inquiry)

		if @inquiry.valid?

			unless @inquiry.use_v2.blank?
				unless Prisma::Recaptcha.verify_recaptcha_v2?(params['g-recaptcha-response'], 'investor_inquiry')
					flash[:alert] = t('global.recaptcha_failed')
					@show_recaptcha_v2 = true
				else
					create_data
				end
			else
				unless Prisma::Recaptcha.verify_recaptcha?(params[:recaptcha_token], 'investor_inquiry')
					flash[:alert] = t('global.recaptcha_failed')
					@show_recaptcha_v2 = true
				else
					create_data
				end
			end

		else
			flash[:alert] = t('inquiries.errors')
		end

    respond_to do |format|
      format.js
    end
  end

  private

  def params_inquiry
    params.require(:inquiry).permit(:name, :email, :phone, :message, :subject, :company_name, :use_v2)
  end

	def create_data
		if @inquiry.save
			flash[:notice] = t('inquiries.success')
			@success = true
			@inquiry = Inquiry.new
		else
			flash[:alert] = t('inquiries.errors')
		end
	end
end
