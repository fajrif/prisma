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
					{
						'@type' => 'ListItem',
						'position' => index + 1,
						'name' => plain_text(name),
						'item' => absolute_url(url)
					}
				end
			)
		end
	end
end
