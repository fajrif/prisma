# Area di dalam hub lokasi (Jakarta Pusat, SCBD, ...). Menjadi section H2 di hub
# (/locations/{location}#{slug}) dan level area di breadcrumb billboard.
class Admins::AreasController < Admins::BaseController
	before_action :set_area, except: %i[index new create]

	def index
		criteria = Area.includes(:location).joins(:location).reorder('locations.id, areas.position, areas.id')
		criteria = criteria.where(location_id: params[:location_id]) if params[:location_id].present?
		@areas = criteria.page(params[:page]).per(25)
	end

	def show
	end

	def new
		@area = Area.new(location_id: params[:location_id])
	end

	def create
		@area = Area.new(params_area)
		@area.position = Area.where(location_id: @area.location_id).maximum(:position).to_i + 1 if @area.position.to_i.zero?
		if @area.save
			redirect_to admins_area_path(@area.id), notice: 'Area berhasil dibuat.'
		else
			render :new, status: :unprocessable_entity
		end
	end

	def edit
	end

	def update
		if @area.update(params_area)
			redirect_to admins_area_path(@area.id), notice: 'Area berhasil diperbarui.'
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		if @area.destroy
			redirect_to admins_areas_path, notice: 'Area dihapus.'
		else
			redirect_to admins_area_path(@area.id), alert: 'Area masih punya billboard; pindahkan billboard-nya ke area lain dulu.'
		end
	end

	private

	def params_area
		params.require(:area).permit(:location_id, :name, :hub_title, :description, :position)
	end

	def set_area
		@area = Area.find(params[:id])
	end
end
