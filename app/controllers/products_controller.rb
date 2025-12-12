class ProductsController < ApplicationController
	before_action :set_banner, only: [:index]
	before_action :set_banner_coming_soon, only: [:show]

  def index

    respond_to do |format|
      format.html {
				render :index
			}
      format.js
    end
  end

  def show
		@product = Product.friendly.find(params[:id])
  end

	protected

	def set_banner
		if @banner_section = BannerSection.find_by_name("Products")
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
