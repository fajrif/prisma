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

	protected

	def set_banner
		if @banner_section = BannerSection.find_by_name("Career")
			current_banner_section_style(@banner_section)
			@banners = @banner_section.banners
		end
	rescue ActiveRecord::RecordNotFound
		puts "No Banner Section Found"
	end

end
