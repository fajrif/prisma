# Sub area: neighbourhood di dalam satu area (judul H3 pada halaman area, sheet SEO 19 Oct).
# Indeks bisa difilter per area; nama & deskripsi diterjemahkan per bahasa admin aktif.
class Admins::SubAreasController < Admins::BaseController
	before_action :set_sub_area, except: %i[index new create]

	def index
		criteria = SubArea.includes(:area, :products).joins(:area)
		criteria = criteria.where(area_id: params[:area_id]) if params[:area_id].present?
		@sub_areas = criteria.page(params[:page]).per(25)
	end

	def show
	end

	def new
		@sub_area = SubArea.new(area_id: params[:area_id])
	end

	def create
		@sub_area = SubArea.new(params_sub_area)
		@sub_area.position = SubArea.where(area_id: @sub_area.area_id).maximum(:position).to_i + 1 if @sub_area.position.to_i.zero?
		if @sub_area.save
			redirect_to admins_sub_area_path(@sub_area.id), notice: 'Sub area berhasil dibuat.'
		else
			render :new, status: :unprocessable_entity
		end
	end

	def edit
	end

	def update
		if @sub_area.update(params_sub_area)
			redirect_to admins_sub_area_path(@sub_area.id), notice: 'Sub area berhasil diperbarui.'
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		if @sub_area.destroy
			redirect_to admins_sub_areas_path(area_id: @sub_area.area_id), notice: 'Sub area dihapus. Titik di dalamnya kembali tampil tanpa judul H3.'
		else
			redirect_to admins_sub_area_path(@sub_area.id), alert: 'Sub area tidak bisa dihapus.'
		end
	end

	private

	def params_sub_area
		params.require(:sub_area).permit(:area_id, :key, :name, :description, :position)
	end

	def set_sub_area
		@sub_area = SubArea.find(params[:id])
	end
end
