module StructuredData
	# Menentukan schema otomatis apa saja yang dipasang pada halaman yang sedang dibuka.
	# Setiap generator dibungkus rescue supaya error pada satu schema tidak menjatuhkan halaman.
	#
	# Pemetaan halaman -> blok mengikuti tabel di prisma-schema-spec.md bagian "Which
	# blocks go on which page".
	class Registry
		LOCATIONS_INDEX_PATH = '/locations'.freeze

		def self.for(record: nil, path: nil, url: nil, trail: [], faq_items: [])
			new(record: record, path: path, url: url, trail: trail, faq_items: faq_items).payloads
		end

		def initialize(record: nil, path: nil, url: nil, trail: [], faq_items: [])
			@record = record
			@path = SchemaMarkup.normalize_path(path)
			@url = url
			@trail = trail
			@faq_items = faq_items
		end

		def payloads
			items = []
			items << safely('Organization') { Organization.call }
			items << safely('WebSite') { WebSite.call }
			items << safely('Breadcrumb') { Breadcrumb.new(trail: @trail).payload }
			items << safely('WebPage') { WebPage.for_path(path: @path, url: @url) }
			items << safely('LocationsIndex') { locations_index_payload }
			items << safely('Record') { record_payload }
			items << safely('FAQPage') { FaqPage.new(items: @faq_items, url: @url).payload } if @faq_items.present?
			items.flatten.compact_blank
		end

		private

		# Arsip /locations tidak punya record tunggal, jadi ditentukan dari path.
		def locations_index_payload
			return unless @path == LOCATIONS_INDEX_PATH

			Collection.for_locations_index(url: @url)
		end

		def record_payload
			case @record
			when ::Article then Article.new(record: @record, url: @url).payload
			when ::Service then Service.new(record: @record, url: @url).payload
			when ::Product then Place.new(record: @record, url: @url).payload
			when ::Location then Collection.for_location(record: @record, url: @url)
			end
		end

		def safely(label)
			yield
		rescue StandardError => e
			Rails.logger.error("[StructuredData] #{label} failed: #{e.class} #{e.message}")
			nil
		end
	end
end
