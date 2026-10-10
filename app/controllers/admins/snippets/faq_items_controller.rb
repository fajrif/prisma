# Butir tanya-jawab blok FAQ (snippet template `faq`). Diisi per bahasa: bahasa yang sedang
# diedit mengikuti pilihan bahasa admin (sama seperti form lain).
class Admins::Snippets::FaqItemsController < Admins::BaseController
	before_action :set_snippet
	before_action :set_faq_item, except: [:new, :create]

	def new
		@faq_item = @snippet.faq_items.build(status: FaqItem::PUBLISHED)
	end

	def create
		@faq_item = @snippet.faq_items.build(params_faq_item)
		if @faq_item.save
			redirect_to admins_snippet_path(@snippet), notice: 'Butir FAQ ditambahkan'
		else
			render :new, status: :unprocessable_entity
		end
	end

	def edit
	end

	def update
		if @faq_item.update(params_faq_item)
			redirect_to admins_snippet_path(@snippet), notice: 'Butir FAQ diperbarui'
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		@faq_item.destroy
		redirect_to admins_snippet_path(@snippet), notice: 'Butir FAQ dihapus'
	end

	private

	def params_faq_item
		params.require(:faq_item).permit(:question, :answer, :order_no, :status)
	end

	def set_snippet
		@snippet = Snippet.find(params[:snippet_id])
	end

	def set_faq_item
		@faq_item = @snippet.faq_items.find(params[:id])
	end
end
