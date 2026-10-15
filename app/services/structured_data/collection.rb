module StructuredData
	# Hub lokasi dan arsip /locations (schema.org/CollectionPage + ItemList).
	# Pemetaan field mengikuti prisma-schema-spec.md bagian 3.
	#
	# Urutan item harus sama dengan urutan yang tampil di halaman.
	class Collection < Base
		def initialize(url:, name:, description: nil, items: [])
			@url = url
			@name = name
			@description = description
			@items = items
		end

		# Hub satu lokasi: daftar titik billboard di dalamnya.
		def self.for_location(record:, url:)
			new(
				url: url,
				name: record.name,
				description: record.description,
				items: record.ordered_products.map { |product| { name: product.name, path: billboard_path(product) } }
			).payload
		end

		# Halaman area: daftar titik di area itu, urutannya sama dengan daftar di halaman.
		def self.for_area(record:, url:)
			new(
				url: url,
				name: I18n.t('locations.area_title', area: record.name),
				description: record.description.presence || I18n.t('seo.area.description', area: record.name, location: record.location.name, count: record.products.size),
				items: record.ordered_products.map { |product| { name: product.name, path: billboard_path(product) } }
			).payload
		end

		# Arsip /locations: daftar ketiga hub.
		def self.for_locations_index(url:)
			new(
				url: url,
				name: I18n.t('locations.title', default: 'Billboard Locations'),
				description: I18n.t('locations.desc', default: nil),
				items: ::Location.all.map { |location| { name: location.name, path: hub_path(location) } }
			).payload
		end

		def self.locale_prefix
			I18n.locale.to_sym == I18n.default_locale.to_sym ? '' : "/#{I18n.locale}"
		end

		def self.billboard_path(product)
			product.public_path
		end

		def self.hub_path(location)
			"#{locale_prefix}/locations/#{location.slug}"
		end

		def payload
			list = item_list_elements
			return if list.empty?

			compact_deep(
				'@type' => 'CollectionPage',
				'@id' => "#{@url}#collection",
				'name' => plain_text(@name),
				'description' => plain_text(@description, limit: 300),
				'url' => @url,
				'about' => organization_ref,
				'mainEntity' => {
					'@type' => 'ItemList',
					'numberOfItems' => list.size,
					'itemListElement' => list
				}
			)
		end

		private

		def item_list_elements
			Array(@items).each_with_index.map do |item, index|
				name = plain_text(item[:name])
				url = absolute_url(item[:path])
				next if name.blank? || url.blank?

				{ '@type' => 'ListItem', 'position' => index + 1, 'url' => url, 'name' => name }
			end.compact
		end
	end
end
