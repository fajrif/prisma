module StructuredData
	class WebSite < Base
		def initialize(setting: nil)
			@setting = setting || ::Setting.current
		end

		def payload
			compact_deep(
				'@type' => 'WebSite',
				'@id' => website_id,
				'url' => base_url,
				'name' => @setting.legal_name.presence || configatron.site_name,
				'description' => plain_text(@setting.description.presence || configatron.site_description, limit: 300),
				'inLanguage' => %w[en id zh-Hans],
				'publisher' => organization_ref
			)
		end
	end
end
