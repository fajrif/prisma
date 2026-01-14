class LocationsController < ApplicationController
	before_action :set_banner, only: [:index]
	# before_action :set_banner_coming_soon, only: [:show]

  def index
  end

  def show
		@location = Location.friendly.find(params[:id])
    @locations = Location.all # for the dropdown
    set_banner_show
    @products = @location.products.where.not(latitude: nil, longitude: nil)
    
    # Filter by billboard_type if provided
    if params[:billboard_type].present?
      @products = @products.where(billboard_type: params[:billboard_type])
    end

    respond_to do |format|
      format.html
      format.js   # show.js.erb for AJAX
      format.json { render json: @products }
    end
  end

	protected

	def set_banner
		if @banner_section = BannerSection.find_by_name("Locations")
			current_banner_section_style(@banner_section)
			@banners = @banner_section.banners
		end
	rescue ActiveRecord::RecordNotFound
		puts "No Banner Section Found"
	end

	def set_banner_show
    if @banner_section = @location.banner_section
			current_banner_section_style(@banner_section)
			@banners = @banner_section.banners
		end
	rescue ActiveRecord::RecordNotFound
		puts "No Banner Section Found"
	end

	def set_banner_coming_soon
		if @banner_section = BannerSection.find_by_name("Coming Soon")
			current_banner_section_style(@banner_section)
			@banners = @banner_section.banners
		end
	rescue ActiveRecord::RecordNotFound
		puts "No Banner Section Found"
	end
end
