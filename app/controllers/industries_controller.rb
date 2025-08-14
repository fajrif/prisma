class IndustriesController < ApplicationController
	before_action :set_banner, only: [:index]

  def index
    @industries = Industry.all

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
		@industry = Industry.friendly.find(params[:id])
    set_data_page
  end

	protected

	def set_banner
		if @banner_section = BannerSection.find_by_name("Industries")
			current_banner_section_style(@banner_section)
			@banners = @banner_section.banners
		end

    set_data_page
	rescue ActiveRecord::RecordNotFound
		puts "No Banner Section Found"
	end

	def set_data_page
    # if @page = Page.friendly.find("home")
    #   @sections = Section.joins(:snippet)
    #               .where(page_id: @page.id)
    #               .where(snippets: { name: ['our_portfolios', 'our_industries'] })
    # end
	rescue ActiveRecord::RecordNotFound
		puts "No Page Found"
	end
end
