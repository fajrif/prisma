class ArticlesController < ApplicationController
	before_action :set_banner, only: [:index]

  def index
    criteria = Article.listed_in
		@articles = criteria.page(params[:page]).per(12)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
		@article = Article.friendly.find(params[:id])
		# EN tanpa fallback: artikel yang tidak punya teks di rantai bahasa ini diarahkan ke
		# versi yang punya isinya (bukan dirender kosong). 302: terjemahan bisa menyusul kapan saja.
		if (target = @article.redirect_locale_for(I18n.locale))
			return redirect_to "/#{target}/articles/#{@article.slug}", status: :found, allow_other_host: false
		end
		@schema_subject = @article
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
