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
		@schema_subject = @article
		@meta_title = @article.meta_title unless @article.meta_title.blank?
		@meta_desc = @article.meta_description unless @article.meta_description.blank?
		@articles = Article.most_recent_articles(@article.id, 3)
	rescue ActiveRecord::RecordNotFound
		# Artikel yang dihapus atau berganti slug punya padanan di config/redirects.yml;
		# tanpa ini URL-nya hanya 404 padahal kontennya masih hidup di slug lain.
		redirect_to_renamed_article!
  end

	protected

	def redirect_to_renamed_article!
		target = RedirectMap.article(params[:id])
		raise ActiveRecord::RecordNotFound, "Article not found" if target.blank?
		raise ActiveRecord::RecordNotFound, "Article not found" unless Article.exists?(slug: target)

		forced = RedirectMap.article_locale(target)
		prefix = if forced.present?
			"/#{forced}"
		else
			I18n.locale.to_sym == I18n.default_locale.to_sym ? '' : "/#{I18n.locale}"
		end

		redirect_to "#{prefix}/articles/#{target}", status: :moved_permanently, allow_other_host: false
	end

	def set_banner
		if @banner_section = BannerSection.find_by_name("Blog")
			current_banner_section_style(@banner_section)
			@banners = @banner_section.banners
		end
	rescue ActiveRecord::RecordNotFound
		puts "No Banner Section Found"
	end

end
