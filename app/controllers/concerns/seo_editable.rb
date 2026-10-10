# Form "SEO & Social" terpisah dari form edit utama (meta title/description, social, robots,
# canonical). Dipasang di controller admin Page, Article, Industry, Portfolio, Service,
# Location, Product; rute lewat `concern :seo_editable` di config/routes.rb.
#
# Record diambil dari @<model> (mis. @page) yang sudah diisi before_action set_<model> milik
# controller masing-masing. Hanya seo_setting_attributes yang di-permit di sini.
module SeoEditable
	extend ActiveSupport::Concern

	def edit_seo
		@seo_record = seo_record
		@seo_record.seo # membangun seo_setting bila belum ada, supaya form punya objek
		render 'admins/shared/seo_edit'
	end

	def update_seo
		@seo_record = seo_record
		if @seo_record.update(params.require(@seo_record.model_name.param_key).permit(seo_setting_attributes: HasSeoSetting::PERMITTED))
			redirect_to seo_show_path(@seo_record), notice: 'SEO & Social disimpan.'
		else
			render 'admins/shared/seo_edit', status: :unprocessable_entity
		end
	end

	private

	def seo_record
		instance_variable_get("@#{controller_name.singularize}")
	end

	def seo_show_path(record)
		url_for(controller: controller_name, action: :show, id: record.id, only_path: true, anchor: 'seo-details')
	end
end
