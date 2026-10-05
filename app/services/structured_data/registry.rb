module StructuredData
	# Menentukan schema otomatis apa saja yang dipasang pada halaman yang sedang dibuka.
	# Setiap generator dibungkus rescue supaya error pada satu schema tidak menjatuhkan halaman.
	class Registry
		LOCAL_BUSINESS_PATHS = ['/', '/contact-us', '/about-us'].freeze

		def self.for(record: nil, path: nil, url: nil, trail: [])
			new(record: record, path: path, url: url, trail: trail).payloads
		end

		def initialize(record: nil, path: nil, url: nil, trail: [])
			@record = record
			@path = SchemaMarkup.normalize_path(path)
			@url = url
			@trail = trail
		end

		def payloads
			items = []
			items << safely('Organization') { Organization.call }
			items << safely('WebSite') { WebSite.call }
			items.concat(safely('LocalBusiness') { LocalBusiness.all } || []) if local_business_page?
			items << safely('Breadcrumb') { Breadcrumb.new(trail: @trail).payload }
			items << safely('Record') { record_payload }
			items.flatten.compact_blank
		end

		private

		def local_business_page?
			LOCAL_BUSINESS_PATHS.include?(@path)
		end

		def record_payload
			case @record
			when ::Article then Article.new(record: @record, url: @url).payload
			when ::Service then Service.new(record: @record, url: @url).payload
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
