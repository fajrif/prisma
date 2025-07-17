class ArchivesController < ApplicationController
	before_action :set_data_page
	before_action :set_archive_type

  def index
		@archive_types = ArchiveType.get_gms_types
		if @archive_type
			criteria = @archive_type.archives.where(status: 1)

			@archives = check_params_filter(criteria)
		end

    respond_to do |format|
      format.html # index.html.erb
      format.js { render :index }
    end
  end

	def disclosure_information
		if @archive_type
			criteria = @archive_type.archives.where(status: 1)

			@archives = check_params_filter(criteria)
		end

    respond_to do |format|
      format.html # index.html.erb
      format.js { render :index }
    end
	end

	def articles_association
		if @archive_type
			criteria = @archive_type.archives.where(status: 1)

			@archives = check_params_filter(criteria)
		end

    respond_to do |format|
      format.html # index.html.erb
      format.js { render :index }
    end
	end

	protected

	def check_params_filter(_criteria)
		unless params[:category].blank?
			_criteria = _criteria.where("category_name = ?", "#{params[:category]}")
		end

		unless params[:year].blank?
			_criteria = _criteria.where("date_part('year', published_date) = ?", "#{params[:year]}")
		end

		unless params[:sort_by].blank?
			_criteria = _criteria.unscope(:order).order("published_date " + params[:sort_by])
		end
		return _criteria
	end

	def set_archive_type
		@archive_type = ArchiveType.friendly.find(params[:id])
	end

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
