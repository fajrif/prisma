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

  # /billboards/:id. Bila path tidak sama dengan public_path (mis. trailing slash),
  # 301 ke URL yang benar.
  def show
		@product = Product.unscoped.includes(:location, :area).find_by!(slug: params[:id].to_s)
		canonical = @product.public_path
		return redirect_to(canonical, status: :moved_permanently, allow_other_host: false) if request.path != canonical

		@schema_subject = @product
		@area = @product.area
		@location = @product.location
		# Tombol WhatsApp di footer: pesan langsung menanyakan titik ini (tipe, area, URL).
		@whatsapp_text = t('global.whatsapp_product', type: @product.type_name, area: (@area || @location)&.name,
		                                              url: "#{configatron.site_url}#{@product.public_path}")
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
