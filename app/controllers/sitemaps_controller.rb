# Sitemap dibangkitkan dari database (lihat SitemapBuilder), menggantikan file statis
# hasil crawl Pro-Sitemaps yang dulu ada di public/.
#
# Cache HTTP 1 jam + Last-Modified: crawler yang mengirim If-Modified-Since mendapat 304
# selama tidak ada konten yang berubah.
class SitemapsController < ApplicationController
	def index
		builder = SitemapBuilder.new
		@sections = SitemapBuilder::SECTIONS.map { |section| [section, builder.lastmod(section)] }
		respond_with_cache(@sections.map(&:last).compact.max)
	end

	def show
		@entries = SitemapBuilder.new.entries(params[:section])
		respond_with_cache(@entries.map { |entry| entry[:lastmod] }.compact.max)
	end

	private

	def respond_with_cache(last_modified)
		expires_in 1.hour, public: true
		fresh_when(last_modified: last_modified, public: true) if last_modified
	end
end
