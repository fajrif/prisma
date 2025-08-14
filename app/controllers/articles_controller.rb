class ArticlesController < ApplicationController
	before_action :set_banner, only: [:index]

  def index
    criteria = Article.all
		@articles = criteria.page(params[:page]).per(12)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
		@article = Article.friendly.find(params[:id])
    set_data_page
		@meta_title = @article.meta_title unless @article.meta_title.blank?
		@meta_desc = @article.meta_description unless @article.meta_description.blank?
		@articles = Article.most_recent_articles(@article.id, 3)
  end

	protected

	def set_banner
		if @banner_section = BannerSection.find_by_name("Blog")
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
