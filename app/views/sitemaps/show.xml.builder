# hreflang mengikuti tag <head> (SeoHelper#html_lang_code): cn -> zh-Hans.
hreflang = { en: 'en', id: 'id', cn: 'zh-Hans' }

xml.instruct! :xml, version: '1.0', encoding: 'UTF-8'
xml.urlset xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9', 'xmlns:xhtml' => 'http://www.w3.org/1999/xhtml' do
	@entries.each do |entry|
		xml.url do
			xml.loc entry[:loc]
			xml.lastmod entry[:lastmod].in_time_zone('Asia/Jakarta').iso8601 if entry[:lastmod]

			alternates = entry[:alternates]
			next if alternates.size < 2

			alternates.each do |locale, href|
				xml.tag! 'xhtml:link', rel: 'alternate', hreflang: hreflang.fetch(locale), href: href
			end
			xml.tag! 'xhtml:link', rel: 'alternate', hreflang: 'x-default', href: alternates[:en] || alternates[:id]
		end
	end
end
