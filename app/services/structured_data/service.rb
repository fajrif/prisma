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
				'serviceType' => plain_text(@record.caption),
				'description' => description,
				'url' => @url,
				'inLanguage' => locale_code,
				'provider' => organization_ref,
				'areaServed' => { '@type' => 'Country', 'name' => 'Indonesia' }
			)
		end

		private

		def description
			plain_text(@record.meta_description.presence || @record.short_description.presence || @record.description,
								 limit: 500)
		end
	end
end
