class CareersController < ApplicationController
	before_action :set_banner

  def index
		@careers = Career.all

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
		@career = Career.friendly.find(params[:id])
  end

  def create
		@success = false
		@application = Application.new(params_application)

		if @application.valid?

			unless @application.use_v2.blank?
				unless Prisma::Recaptcha.verify_recaptcha_v2?(params['g-recaptcha-response'], 'application')
					flash[:alert] = t('global.recaptcha_failed')
					@show_recaptcha_v2 = true
				else
					create_data
				end
			else
				unless Prisma::Recaptcha.verify_recaptcha?(params[:recaptcha_token], 'application')
					flash[:alert] = t('global.recaptcha_failed')
					@show_recaptcha_v2 = true
				else
					create_data
				end
			end

		else
			flash[:alert] = t('applications.errors')
		end

    respond_to do |format|
      format.js
    end
  end

	protected

	def set_banner
		if @banner_section = BannerSection.find_by_name("Career")
			current_banner_section_style(@banner_section)
			@banners = @banner_section.banners
		end
	rescue ActiveRecord::RecordNotFound
		puts "No Banner Section Found"
	end

  def params_application
    params.require(:application).permit(:name, :email, :phone, :file, :career_id, :use_v2)
  end

	def create_data
		if @application.save
			flash[:notice] = t('applications.success')
			@success = true
			@application = Application.new
		else
			flash[:alert] = t('applications.errors')
		end
	end
end
