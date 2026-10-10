# Pemasangan blok FAQ/tabel (snippet) pada Article, Location, Industry, Product lewat modal
# di tab "Block FAQ" halaman detail admin. Pola sama dengan Admins::Snippets::LinkButtonsController
# (respons JS yang mengisi #myModal dan menyegarkan daftar). Rute dari `concern :content_blockable`.
class Admins::ContentBlocksController < Admins::BaseController
	PLACEABLE_PARAMS = { article_id: Article, location_id: Location, industry_id: Industry, product_id: Product }.freeze

	before_action :set_placeable
	before_action :set_block, except: %i[new create]

	def new
		@block = @placeable.content_blocks.build(order_no: @placeable.content_blocks.maximum(:order_no).to_i + 1)
		respond_to { |format| format.js { render :form } }
	end

	def create
		@block = @placeable.content_blocks.build(block_params)
		@success = @block.save
		flash[:notice] = 'Blok ditambahkan.' if @success
		respond_to { |format| format.js { render(@success ? :update : :form) } }
	end

	def edit
		respond_to { |format| format.js { render :form } }
	end

	def update
		@success = @block.update(block_params)
		flash[:notice] = 'Blok diperbarui.' if @success
		respond_to { |format| format.js { render(@success ? :update : :form) } }
	end

	def destroy
		@block.destroy
		@success = true
		flash[:notice] = 'Blok dihapus.'
		respond_to { |format| format.js { render :update } }
	end

	private

	def set_placeable
		key, klass = PLACEABLE_PARAMS.find { |param, _| params[param].present? }
		raise ActiveRecord::RecordNotFound, 'placeable tidak dikenal' unless key

		@placeable = klass.unscoped.friendly.find(params[key]) # slug (to_param) atau id
	end

	def set_block
		@block = @placeable.content_blocks.find(params[:id])
	end

	def block_params
		params.require(:content_block).permit(:snippet_id, :order_no, :hidden)
	end
end
