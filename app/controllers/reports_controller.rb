class ReportsController < ApplicationController
	before_action :set_data_page

  def index
		@report_types = ReportType.all
		if @report_type = ReportType.friendly.find(params[:id])
			criteria = @report_type.reports.where(status: 1)

			unless params[:year].blank?
				criteria = criteria.where("date_part('year', published_date) = ?", "#{params[:year]}")
			end

			unless params[:sort_by].blank?
				criteria = criteria.unscope(:order).order("published_date " + params[:sort_by])
			end

			@reports = criteria
		end

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

	protected

	def set_data_page
		if @page = Page.friendly.find(params[:id])
			@meta_title = @page.meta_title unless @page.meta_title.blank?
			@meta_desc = @page.meta_description unless @page.meta_description.blank?
			current_banner_section_style(@page.banner_section)
			@banners = @page.banners
		end
	rescue ActiveRecord::RecordNotFound
		puts "No Page Found"
	end
end
