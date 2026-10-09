xml.instruct! :xml, version: '1.0', encoding: 'UTF-8'
xml.sitemapindex xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9' do
	@sections.each do |section, lastmod|
		xml.sitemap do
			xml.loc "#{configatron.site_url}/sitemap-#{section}.xml"
			xml.lastmod lastmod.in_time_zone('Asia/Jakarta').iso8601 if lastmod
		end
	end
end
