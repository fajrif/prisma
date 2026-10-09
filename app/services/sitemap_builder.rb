# Membangun isi sitemap dari database. Dipakai SitemapsController.
#
# Tiap entri: { loc:, lastmod:, alternates: { en: url, id: url, cn: url } }
# Satu entri per URL per bahasa; `alternates` hanya memuat versi bahasa yang ikut
# dimasukkan, sehingga hreflang di sitemap selalu menunjuk URL yang benar-benar ada.
#
# Yang dikecualikan:
#   - draft (Page, Article, Career)
#   - record yang di panel SEO & Social diberi robots `noindex`
#   - record yang canonical-nya dialihkan ke URL lain (sitemap hanya berisi URL kanonik)
class SitemapBuilder
	SECTIONS = %w[pages locations billboards articles].freeze
	LOCALES = %i[en id cn].freeze
	PUBLISHED = 1

	def self.lastmod(section)
		new.lastmod(section)
	end

	def entries(section)
		case section.to_s
		when 'pages' then pages
		when 'locations' then locations
		when 'billboards' then billboards
		when 'articles' then articles
		else raise ArgumentError, "section tidak dikenal: #{section}"
		end
	end

	# Tanggal terbaru di sebuah section; dipakai sitemap index dan header Last-Modified.
	def lastmod(section)
		entries(section).map { |e| e[:lastmod] }.compact.max
	end

	private

	def routes
		Rails.application.routes.url_helpers
	end

	# --- section ---------------------------------------------------------------

	def pages
		list = []

		home = published_pages.find { |p| p.slug == 'home' }
		list.concat(group(home&.content_modified_at) { |l| routes.root_path(locale: param(l)) })

		published_pages.reject { |p| p.slug == 'home' }.each do |page|

			list.concat(group(page.content_modified_at, record: page) { |l| routes.page_path(page.slug, locale: param(l)) })
		end

		# Halaman index: lastmod = record anak terbaru
		list.concat(group(max_modified(published_articles)) { |l| routes.articles_path(locale: param(l)) })
		list.concat(group(max_modified(Portfolio.all)) { |l| routes.portfolios_path(locale: param(l)) })
		list.concat(group(max_modified(Industry.all)) { |l| routes.industries_path(locale: param(l)) })
		list.concat(group(nil) { |l| routes.contact_us_path(locale: param(l)) })

		{ Service => :service_path, Industry => :industry_path, Portfolio => :portfolio_path }.each do |model, helper|
			model.all.each do |record|

				list.concat(group(record.content_modified_at, record: record) { |l| routes.public_send(helper, record.slug, locale: param(l)) })
			end
		end

		Career.where(status: PUBLISHED).each do |career|

			list.concat(group(career.content_modified_at, record: career) { |l| routes.career_path(career.slug, locale: param(l)) })
		end

		list
	end

	def locations
		hubs = Location.all.to_a
		list = group(hubs.map(&:content_modified_at).compact.max) { |l| routes.locations_path(locale: param(l)) }

		hubs.each do |location|

			list.concat(group(location.content_modified_at, record: location) { |l| routes.location_path(location.slug, locale: param(l)) })
		end
		list
	end

	def billboards
		Product.unscoped.order(:id).flat_map do |product|

			group(product.content_modified_at, record: product) { |l| routes.product_path(product.slug, locale: param(l)) }
		end
	end

	# Artikel hanya dimasukkan dalam bahasa yang benar-benar punya isinya sendiri.
	# Dibaca dari data mentah, BUKAN lewat Mobility: fallback en<->id membuat setiap
	# artikel tampak punya versi kedua bahasa.
	def articles
		content_locales = ActionText::RichText.where(record_type: 'Article', name: 'content')
																					.where.not(body: [nil, ''])
																					.pluck(:record_id, :locale)
																					.group_by(&:first)
																					.transform_values { |rows| rows.map { |r| r.last.to_s } }

		published_articles.flat_map do |article|

			titles = article.read_attribute(:title) || {}
			locales = LOCALES.select do |l|
				has_title = titles[l.to_s].to_s.strip.present?
				# ID adalah bahasa utama artikel: cukup ada title. EN/CN wajib punya isi sendiri.
				l == :id ? has_title : has_title && content_locales.fetch(article.id, []).include?(l.to_s)
			end

			group(article.content_modified_at, locales: locales, record: article) { |l| routes.article_path(article.slug, locale: param(l)) }
		end
	end

	# --- util --------------------------------------------------------------------

	# Satu entri per bahasa dengan alternates yang saling menunjuk.
	def group(lastmod, locales: LOCALES, record: nil)
		return [] if locales.empty?

		urls = locales.index_with { |l| absolute(yield(l)) }
		return [] if record && excluded?(record, urls.values)

		urls.map { |_, loc| { loc: loc, lastmod: lastmod, alternates: urls } }
	end

	def absolute(path)
		path = path.to_s
		path = path.chomp('/') unless path == '/'
		"#{configatron.site_url}#{path}"
	end

	# Bahasa default (en) tanpa prefix di URL.
	def param(locale)
		locale.to_sym == I18n.default_locale.to_sym ? nil : locale.to_s
	end

	def published_pages
		@published_pages ||= Page.where(status: PUBLISHED).to_a
	end

	def published_articles
		@published_articles ||= Article.where(status: PUBLISHED).to_a
	end

	def max_modified(records)
		records.map(&:content_modified_at).compact.max
	end

	# Memakai aturan yang sama dengan <head> halaman (SeoMeta), supaya sitemap tidak
	# mengajukan URL yang di halamannya sendiri bilang noindex atau canonical ke tempat lain.
	def excluded?(record, own_urls)
		return false unless record.respond_to?(:seo_setting) && record.seo_setting

		meta = SeoMeta.new(record: record)
		return true if meta.robots.include?('noindex')

		# Canonical yang menunjuk ke URL record ini sendiri bukan alasan untuk membuangnya.
		override = meta.canonical_override
		override.present? && !own_urls.include?(override)
	end
end
