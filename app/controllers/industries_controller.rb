class IndustriesController < ApplicationController
	before_action :set_banner, only: [:index]

  def index
    @industries = Industry.all
  end

  def show
		@industry = Industry.friendly.find(params[:id])
		@meta_title = @industry.meta_title unless @industry.meta_title.blank?
		@meta_desc = @industry.meta_description unless @industry.meta_description.blank?
    set_banner_section
  end

	protected

	def set_banner
		if @banner_section = BannerSection.find_by_name("Industries")
			current_banner_section_style(@banner_section)
			@banners = @banner_section.banners
		end
	rescue ActiveRecord::RecordNotFound
		puts "No Banner Section Found"
	end

	def set_banner_section
    if @banner_section = @industry.banner_section
			current_banner_section_style(@banner_section)
			@banners = @banner_section.banners
		end
	rescue ActiveRecord::RecordNotFound
		puts "No Banner Section Found"
	end

end
