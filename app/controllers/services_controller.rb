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
    set_banner_individual
  end

	protected

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
