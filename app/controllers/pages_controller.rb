class PagesController < ApplicationController

  def show
		# get public page
		begin
			_id = params[:id]

			if _id == 'id'
				_id = "home"
				I18n.locale = :id
			end

			if @page = Page.friendly.find(_id)
        if @page.published?
          @meta_title = @page.meta_title unless @page.meta_title.blank?
          @meta_desc = @page.meta_description unless @page.meta_description.blank?
          current_banner_section_style(@page.banner_section)
          @banners = @page.banners
          @sections = @page.sections
        else
          raise ActiveRecord::RecordNotFound, "Unpublished page"
        end
			end

		rescue ActiveRecord::RecordNotFound
      raise ActiveRecord::RecordNotFound, "Page not found"
		end
  end

end
