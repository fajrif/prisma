module StructuredData
	class Service < Base
		def initialize(record:, url: nil)
			@record = record
			@url = url
		end

		def payload
			return if @record.blank?

			compact_deep(
				'@type' => 'Service',
				'@id' => "#{@url}#service",
				'name' => plain_text(@record.name),
				'serviceType' => service_type,
				'description' => description,
				'url' => @url,
				'inLanguage' => locale_code,
				'provider' => provider_ref,
				'areaServed' => area_served
			)
		end

		private

		# Kategori layanan, bukan tagline. Kolom `caption` sempat dipakai di sini dan
		# menghasilkan nilai seperti "Command Attention with High-Impact Static
		# Billboard Advertising", yang bukan serviceType yang valid.
		def service_type
			@record.service_type.presence
		end

		# Layanan PiX disediakan organisasi lain, jadi provider-nya bukan Prisma.
		def provider_ref
			override = @record.schema_provider_url.presence
			override ? { '@id' => override } : organization_ref
		end

		def area_served
			areas = Array(@record.area_served).map do |area|
				type = area['type'].presence || area[:type]
				name = area['name'].presence || area[:name]
				{ '@type' => type, 'name' => name } if type.present? && name.present?
			end.compact

			areas.presence
		end

		def description
			plain_text(seo_description.presence || @record.short_description.presence || @record.description,
								 limit: 500)
		end
	end
end
