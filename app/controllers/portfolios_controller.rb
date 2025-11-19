class PortfoliosController < ApplicationController
	before_action :set_banner, only: [:index]

  def index
    criteria = Portfolio.all
		@portfolios = criteria.page(params[:page]).per(12)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
		@portfolio = Portfolio.friendly.find(params[:id])
		@meta_title = @portfolio.meta_title unless @portfolio.meta_title.blank?
		@meta_desc = @portfolio.meta_description unless @portfolio.meta_description.blank?
  end

	protected

	def set_banner
		if @banner_section = BannerSection.find_by_name("Portfolio")
			current_banner_section_style(@banner_section)
			@banners = @banner_section.banners
		end
	rescue ActiveRecord::RecordNotFound
		puts "No Banner Section Found"
	end

end
