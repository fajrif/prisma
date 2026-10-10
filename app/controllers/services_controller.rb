class ServicesController < ApplicationController
	before_action :set_banner, only: [:index]

  def index
		@services = Service.all

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
		@service = Service.friendly.find(params[:id])
		@schema_subject = @service
    @sections = @service.segments


    set_banner_individual
	rescue ActiveRecord::RecordNotFound
		redirect_to_renamed_service!
  end

	protected

	def redirect_to_renamed_service!
		target = RedirectMap.service(params[:id])
		raise ActiveRecord::RecordNotFound, "Service not found" if target.blank?
		raise ActiveRecord::RecordNotFound, "Service not found" unless Service.exists?(slug: target)

		prefix = I18n.locale.to_sym == I18n.default_locale.to_sym ? '' : "/#{I18n.locale}"
		redirect_to "#{prefix}/services/#{target}", status: :moved_permanently, allow_other_host: false
	end

	def set_banner
		if @banner_section = BannerSection.find_by_name("Services")
			current_banner_section_style(@banner_section)
			@banners = @banner_section.banners
		end
	rescue ActiveRecord::RecordNotFound
		puts "No Banner Section Found"
	end

	def set_banner_individual
    if @banner_section = @service.banner_section
			current_banner_section_style(@banner_section)
			@banners = @banner_section.banners
		end
	rescue ActiveRecord::RecordNotFound
		puts "No Banner Section Found"
	end

end
