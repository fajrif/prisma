class PagesController < ApplicationController

  def show
		# get public page
		begin
			_id = params[:id]

			if _id == 'cn'
				_id = "home"
				I18n.locale = :cn
			end

			if @page = Page.friendly.find(_id)
				@meta_title = @page.meta_title unless @page.meta_title.blank?
				@meta_desc = @page.meta_description unless @page.meta_description.blank?
				current_banner_section_style(@page.banner_section)
				@banners = @page.banners
				@sections = @page.sections
			end

		rescue ActiveRecord::RecordNotFound
			raise ActionController::RoutingError.new('Not Found')
		end
  end

end
