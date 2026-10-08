module StructuredData
	# trail berupa array [[nama, url], ...] dari SeoHelper#breadcrumb_trail
	class Breadcrumb < Base
		def initialize(trail:)
			@trail = Array(trail)
		end

		def payload
			return if @trail.size < 2

			compact_deep(
				'@type' => 'BreadcrumbList',
				'itemListElement' => @trail.each_with_index.map do |(name, url), index|
					last = index == @trail.size - 1
					{
						'@type' => 'ListItem',
						'position' => index + 1,
						'name' => plain_text(name),
						# Spec: item terakhir adalah halaman saat ini dan tidak memakai `item`.
						'item' => last ? nil : absolute_url(url)
					}.compact
				end
			)
		end
	end
end
