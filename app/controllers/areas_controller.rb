# Halaman area: /locations/:location_id/:id, mis. /locations/jakarta/jakarta-pusat.
# Tampilannya sama dengan hub (filter, daftar, peta), berisi titik di area itu saja.
class AreasController < ApplicationController
	def show
		@location = Location.friendly.find(params[:location_id])
		@area = @location.areas.friendly.find_by(slug: params[:id].to_s)
		# Area yang sudah diganti nama/dihapus: kembali ke hub, bukan 404.
		return redirect_to(@location.public_path, status: :moved_permanently, allow_other_host: false) unless @area

		@schema_subject = @area
		set_banner
		@products = @area.products.includes(:location, :area).where.not(latitude: nil, longitude: nil)
		@products = @products.where(billboard_type: params[:billboard_type]) if Product.billboard_types.key?(params[:billboard_type])

		respond_to do |format|
			format.html
			format.js { render 'locations/show' }
		end
	end

	private

	def set_banner
		@banner_section = @area.effective_banner_section
		return unless @banner_section

		current_banner_section_style(@banner_section)
		@banners = @banner_section.banners
	end
end
