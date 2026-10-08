class PagesController < ApplicationController
	# URL WordPress lama berbentuk /?p=123 masih dikutip dan sebelumnya dibalas 200
	# berisi beranda, yang dari sisi crawler adalah duplikat.
	before_action :redirect_legacy_query_param, only: [:show]

  def show
		# get public page
		begin
			_id = params[:id]

			if _id == 'id'
				_id = "home"
				I18n.locale = :id
			end

			if _id == 'cn'
				_id = "home"
				I18n.locale = :cn
			end

			if @page = Page.friendly.find(_id)
        if @page.published?
          @schema_subject = @page
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
      raise ActiveRecord::RecordNotFound, "Page not found" unless redirect_legacy_article_slug!
		end
  end

	private

	def redirect_legacy_query_param
		return if params[:p].blank?

		target = RedirectMap.query_p(params[:p]) || '/'
		destination = target == '/' ? (locale_prefix.presence || '/') : "#{locale_prefix}#{target}"

		redirect_to destination, status: :moved_permanently, allow_other_host: false
	end

	# Pada /id dan /cn bahasa ada di params[:id], bukan params[:locale] (lihat hack
	# di #show), dan before_action berjalan sebelum hack itu menyetel I18n.locale.
	def locale_prefix
		code = params[:locale].presence || (%w[id cn].include?(params[:id]) ? params[:id] : nil)
		code.present? ? "/#{code}" : ''
	end

	# Sebagian artikel lama hidup di URL tanpa prefix /articles/. URL itu jatuh ke
	# catch-all ini, jadi padanannya dicek sebelum menyerah ke 404.
	def redirect_legacy_article_slug!
		target = RedirectMap.article(params[:id])
		return false if target.blank? || !Article.exists?(slug: target)

		forced = RedirectMap.article_locale(target)
		prefix = forced.present? ? "/#{forced}" : locale_prefix
		redirect_to "#{prefix}/articles/#{target}", status: :moved_permanently, allow_other_host: false
		true
	end

end
