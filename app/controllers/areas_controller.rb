# URL lama halaman area (/locations/:location_id/:id, mis. /locations/jakarta/jakarta-pusat).
# Area kini section di hub, jadi semua permintaan di-301 satu hop ke /locations/jakarta#jakarta-pusat.
# Query (mis. ?billboard_type=) ikut dibawa; slug yang tidak dikenal kembali ke hub, bukan 404.
class AreasController < ApplicationController
	def show
		location = Location.friendly.find(params[:location_id])
		area = location.areas.friendly.find_by(slug: params[:id].to_s)
		query = request.query_string.present? ? "?#{request.query_string}" : ''
		anchor = area && location.areas.size > 1 ? "##{area.slug}" : ''
		target = "#{location.public_path}#{query}#{anchor}"

		redirect_to target, status: :moved_permanently, allow_other_host: false
	end
end
